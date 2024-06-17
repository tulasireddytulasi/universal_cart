import 'package:flutter/material.dart';
import 'package:universal_cart/app/core/utils/color_palette.dart';

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
        children: [

        ],
      ),
    );
  }
}
