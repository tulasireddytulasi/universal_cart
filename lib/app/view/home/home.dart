import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_cart/app/core/utils/app_styles.dart';
import 'package:universal_cart/app/core/utils/color_palette.dart';
import 'package:universal_cart/app/core/utils/constants.dart';
import 'package:universal_cart/app/model/cart_model.dart';
import 'package:universal_cart/app/view/home/widget/cart_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  double _totalPrice = 0.0;
  double _totalDiscount = 0.0;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    final String response = await rootBundle.loadString('assets/json/products_object.json');
    final data = await json.decode(response);

    final cartResponse = CartModel.fromJson(data);
    products = cartResponse.products ?? [];
    products += products;
    products.shuffle();
    double totalPrice = 0.0;
    double totalDiscount = 0.0;

    for (var product in products) {
      totalPrice += product.price ?? 0;
      totalDiscount += product.discount ?? 0;
    }

    _totalPrice = totalPrice;
    _totalDiscount = totalDiscount;
    setState(() {});
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
                  "Your cart (${products.length} items)",
                  textAlign: TextAlign.center,
                  style: AppStyles.bodySmall.copyWith(
                    color: ColorPalette.grey1,
                    fontFamily: Constants.montserratMedium,
                  ),
                ),
                const Spacer(),
                Text(
                  "$_totalPrice Rs",
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
                itemCount: products.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CartItemWidget(
                    name: products[index].name ?? "",
                    brand: products[index].brand ?? "",
                    price: double.parse(products[index].price.toString()),
                    discount: double.parse(products[index].discount.toString()),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
