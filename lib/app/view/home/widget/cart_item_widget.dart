import 'package:flutter/material.dart';
import 'package:universal_cart/app/core/utils/app_styles.dart';
import 'package:universal_cart/app/core/utils/color_palette.dart';
import 'package:universal_cart/app/core/utils/constants.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.name, required this.brand, required this.price});

  final String name;
  final String brand;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPalette.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: AppStyles.titleSmall,
                ),
                Text(
                  brand,
                  textAlign: TextAlign.center,
                  style: AppStyles.bodySmall.copyWith(
                    color: ColorPalette.grey1,
                    fontFamily: Constants.montserratMedium,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "$price Rs",
            textAlign: TextAlign.center,
            style: AppStyles.titleSmall.copyWith(
              color: ColorPalette.grey1,
              fontFamily: Constants.montserratMedium,
            ),
          ),
        ],
      ),
    );
  }
}
