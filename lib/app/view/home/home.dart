import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_cart/app/core/utils/app_styles.dart';
import 'package:universal_cart/app/core/utils/assets_path.dart';
import 'package:universal_cart/app/core/utils/color_palette.dart';
import 'package:universal_cart/app/core/utils/constants.dart';
import 'package:universal_cart/app/model/cart_model.dart';
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
                          "Your cart (${state.products.length} items)",
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
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: ValueKey<String>(state.products[index].barcode ?? ""),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    context.read<HomeBloc>().add(CartItemRemoved(state.products[index]));
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Item Removed")),
                                    );
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
                                    brand: state.products[index].brand ?? "",
                                    price: double.parse(state.products[index].price.toString()),
                                    discount: double.parse(state.products[index].discount.toString()),
                                  ),
                                );
                              }),
                        )
                      : Expanded(
                          child: Center(
                            child: Text(
                              "No Items in Cart, Please add items.",
                              textAlign: TextAlign.center,
                              style: AppStyles.bodyMedium.copyWith(
                                color: ColorPalette.grey1,
                                fontFamily: Constants.montserratMedium,
                              ),
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
    final Product item = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BarcodeScannerWithController()),
    );

    context.read<HomeBloc>().add(CartItemAdded(item: item));

    // if (item != null) {
    //   print("barcodeValue: ${barcodeValue.toString()}");
    //   // Replace with your API call logic
    //   // fetchProductDetails(barcodeValue);
    // }
  }
}
