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
    return const Scaffold(
      backgroundColor: ColorPalette.red,
    );
  }
}
