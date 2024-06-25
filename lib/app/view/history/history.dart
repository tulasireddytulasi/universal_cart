import 'package:flutter/material.dart';
import 'package:universal_cart/app/core/utils/color_palette.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.antiFlashWhite,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: ColorPalette.white,
        leading: const Icon(Icons.arrow_back_ios_rounded, color: ColorPalette.liteOrange, size: 28),
        title: const Text(
          "History",
          style: TextStyle(fontSize: 22, color: ColorPalette.black),
        ),
        centerTitle: false,
      ),
    );
  }
}
