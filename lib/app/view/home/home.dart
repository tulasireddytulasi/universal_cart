import 'package:flutter/material.dart';
import 'package:universal_cart/app/core/utils/app_styles.dart';
import 'package:universal_cart/app/core/utils/color_palette.dart';
import 'package:universal_cart/app/core/utils/constants.dart';
import 'package:universal_cart/app/view/home/widget/cart_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      ),
      body: Column(
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
                  "Your cart (10 items)",
                  textAlign: TextAlign.center,
                  style: AppStyles.bodySmall.copyWith(
                    color: ColorPalette.grey1,
                    fontFamily: Constants.montserratMedium,
                  ),
                ),
                const Spacer(),
                Text(
                  "580.98 Rs",
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
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 2),
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const CartItemWidget(name: "Organic Almonds 500g", brand: "Nature's Best", price: 230.0);
              },
            ),
          ),
        ],
      ),
    );
  }
}
