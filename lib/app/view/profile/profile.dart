import 'package:flutter/material.dart';
import 'package:universal_cart/app/core/utils/color_palette.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.antiFlashWhite,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: ColorPalette.white,
        leading: const Icon(Icons.arrow_back_ios_rounded, color: ColorPalette.liteOrange, size: 28),
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 22, color: ColorPalette.black),
        ),
        centerTitle: false,
      ),
    );
  }
}
