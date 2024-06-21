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
    return const Scaffold(
      backgroundColor: ColorPalette.lightRed,
    );
  }
}
