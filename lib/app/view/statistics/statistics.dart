import 'package:flutter/material.dart';
import 'package:universal_cart/app/core/utils/color_palette.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.antiFlashWhite,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: ColorPalette.white,
        leading: const Icon(Icons.arrow_back_ios_rounded, color: ColorPalette.liteOrange, size: 28),
        title: const Text(
          "Statistics",
          style: TextStyle(fontSize: 22, color: ColorPalette.black),
        ),
        centerTitle: false,
      ),
    );
  }
}
