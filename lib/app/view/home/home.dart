import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:universal_cart/app/core/utils/app_styles.dart';
import 'package:universal_cart/app/core/utils/assets_path.dart';
import 'package:universal_cart/app/core/utils/color_palette.dart';
import 'package:universal_cart/app/core/utils/constants.dart';
import 'package:universal_cart/app/model/cart_item_model.dart';
import 'package:universal_cart/app/view/history/history.dart';
import 'package:universal_cart/app/view/home/bloc/home_bloc.dart';
import 'package:universal_cart/app/view/home/widget/cart_item_widget.dart';
import 'package:universal_cart/app/view/navigation_menu/custom_bottom_navbar.dart';
import 'package:universal_cart/app/view/profile/profile.dart';
import 'package:universal_cart/app/view/qr_scanner/barcode_scanner_controller.dart';
import 'package:universal_cart/app/view/statistics/statistics.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> bottomBarTitles = ["Home", "Statistics", "Scanner", "History", "Profile"];
  final List<String> iconAssetPaths = [
    Assets.homeIcon,
    Assets.statisticsIcon,
    Assets.scannerIcon,
    Assets.historyIcon,
    Assets.userIcon,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.antiFlashWhite,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: ColorPalette.white,
        leading: const Icon(Icons.home, color: ColorPalette.liteOrange, size: 28),
        title: const Text(
          "Cart",
          style: TextStyle(fontSize: 22, color: ColorPalette.black),
        ),
        centerTitle: false,
        actions: const [
          Icon(Icons.document_scanner_outlined, color: ColorPalette.black, size: 22),
          SizedBox(width: 20),
          Icon(Icons.search, color: ColorPalette.black, size: 24),
          SizedBox(width: 20),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state) {
            case CartLoading():
              return const Center(child: CircularProgressIndicator());
            case CartError():
              return const Text('Something went wrong!');
            case CartLoaded():
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                    color: ColorPalette.white,
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_cart, color: ColorPalette.liteOrange, size: 24),
                        const SizedBox(width: 10),
                        Text(
                          "Your cart (${state.quantity} items)",
                          textAlign: TextAlign.center,
                          style: AppStyles.bodySmall.copyWith(
                            color: ColorPalette.grey1,
                            fontFamily: Constants.montserratMedium,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${state.totalPrice} Rs",
                          textAlign: TextAlign.center,
                          style: AppStyles.bodyMedium.copyWith(
                            color: ColorPalette.grey1,
                            fontFamily: Constants.montserratMedium,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_forward_ios_rounded, color: ColorPalette.liteOrange, size: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  state.products.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                              separatorBuilder: (context, index) => const SizedBox(height: 2),
                              itemCount: state.products.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: ValueKey<String>(state.products[index].itemData.barcode ?? ""),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Item Removed")),
                                    );
                                    context.read<HomeBloc>().add(CartItemRemoved(state.products[index]));
                                  },
                                  background: Container(
                                    color: ColorPalette.red,
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        "Delete",
                                        style: AppStyles.titleSmall,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                  child: CartItemWidget(
                                    name: state.products[index].name ?? "",
                                    brand: state.products[index].itemData.brand ?? "",
                                    price: double.parse(state.products[index].finalPrice.toString()),
                                    discount: double.parse(state.products[index].finalDiscount.toString()),
                                    qty: state.products[index].noOfItems,
                                  ),
                                );
                              }),
                        )
                      : Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 300,
                                  height: 300,
                                  child: Lottie.asset(
                                    Assets.cartEmptyAnimation,
                                    animate: true,
                                    repeat: true,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                RichText(
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Oops!, \n",
                                        style: AppStyles.bodyMedium.copyWith(
                                          fontSize: 18,
                                          color: ColorPalette.grey,
                                          fontFamily: Constants.montserratBold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "No Items in the Cart",
                                        style: AppStyles.bodyMedium.copyWith(
                                          fontSize: 18,
                                          color: ColorPalette.grey,
                                          fontFamily: Constants.montserratMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        defaultSelectedIndex: 0,
        onChange: (value) async {
          switch (value) {
            case 1:
              return Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StatisticsScreen(),
                ),
              );
            case 2:
              scanBarcode();
              break;
            case 3:
              return Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            case 4:
              return Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
          }
        },
        titles: bottomBarTitles,
        imgUrls: iconAssetPaths,
      ),
    );
  }

  Future<void> scanBarcode() async {
    try{
      final CartItemModel? item = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BarcodeScannerWithController()),
      );

      if(!mounted) return;
      item != null ? context.read<HomeBloc>().add(CartItemAdded(item: item)) : null;
    }catch(e, r){
      log("Home error: $e");
      log("Home error r: $r");
    }
  }
}
