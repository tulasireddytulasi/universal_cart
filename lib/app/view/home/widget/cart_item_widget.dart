import 'package:flutter/material.dart';
import 'package:universal_cart/app/core/utils/app_styles.dart';
import 'package:universal_cart/app/core/utils/color_palette.dart';
import 'package:universal_cart/app/core/utils/constants.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.name, required this.brand, required this.price, required this.discount});

  final String name;
  final String brand;
  final double price;
  final double discount;

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
            flex: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.left,
                  style: AppStyles.titleSmall.copyWith(fontFamily: Constants.montserratMedium),
                ),
                Text(
                  brand,
                  textAlign: TextAlign.left,
                  style: AppStyles.bodySmall.copyWith(
                    color: ColorPalette.grey1,
                    fontFamily: Constants.montserratMedium,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 40,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$price Rs",
                  textAlign: TextAlign.end,
                  style: AppStyles.titleSmall.copyWith(
                    color: ColorPalette.black,
                    fontFamily: Constants.montserratMedium,
                  ),
                ),
                discount == 0 ? const SizedBox.shrink() : const SizedBox(height: 4),
                discount == 0 ? const SizedBox.shrink() : Text(
                  "$discount Rs",
                  textAlign: TextAlign.end,
                  style: AppStyles.bodyMedium.copyWith(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: ColorPalette.cottonSeed,
                    color: ColorPalette.cottonSeed,
                    fontFamily: Constants.montserratMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
