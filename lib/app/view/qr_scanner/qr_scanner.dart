import 'package:flutter/material.dart';
import 'package:universal_cart/app/core/utils/color_palette.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorPalette.green,
    );
  }
}
