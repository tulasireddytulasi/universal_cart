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
    return const Scaffold(
      backgroundColor: ColorPalette.orange,
    );
  }
}
