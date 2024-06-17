import 'package:flutter/material.dart';
import 'package:universal_cart/app/core/utils/color_palette.dart';
import 'package:universal_cart/app/core/utils/constants.dart';

class AppStyles {
  static final AppStyles _instance = AppStyles._();

  AppStyles._();

  factory AppStyles.init(BuildContext context) {
    return _instance;
  }

  /// used for button text
  static TextStyle buttonStyle = const TextStyle(
    fontSize: 16,
    color: ColorPalette.white,
    fontFamily: Constants.montserratBold,
  );

  /// used to give style to hint hint of TextFormField,dropdown button
  static TextStyle hintStyle = const TextStyle(
    fontSize: 16,
    color: ColorPalette.black,
    fontFamily: Constants.montserratRegular,
  );

  /// used to give style to error text of TextFormField,dropdown items
  static TextStyle errorStyle = const TextStyle(
    fontSize: 12,
    color: ColorPalette.red,
    fontFamily: Constants.montserratRegular,
  );

  /// used to give style to text such as privacy policy. terms and conditions
  static TextStyle bodySmall = const TextStyle(
    fontSize: 12,
    color: ColorPalette.black,
    fontFamily: Constants.montserratRegular,
  );

  /// used to give style to text of TextFormField, dropdowns items
  static TextStyle bodyMedium = const TextStyle(
    fontSize: 14,
    color: ColorPalette.black,
    fontFamily: Constants.montserratRegular,
  );

  /// used to give style for title for TextFormField dropdown items
  static TextStyle titleSmall = const TextStyle(
    fontSize: 18,
    color: ColorPalette.black,
    fontFamily: Constants.montserratRegular,
  );

  static TextStyle titleMedium = const TextStyle(
    fontSize: 20,
    color: ColorPalette.black,
    fontFamily: Constants.montserratRegular,
  );

  static TextStyle titleBig = const TextStyle(
    fontSize: 22,
    color: ColorPalette.black,
    fontFamily: Constants.montserratBold,
  );
}