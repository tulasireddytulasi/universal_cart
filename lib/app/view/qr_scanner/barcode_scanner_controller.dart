import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:universal_cart/app/core/utils/assets_path.dart';
import 'package:universal_cart/app/core/utils/color_palette.dart';
import 'package:universal_cart/app/view/qr_scanner/bloc/barcode_scanner_bloc.dart';
import 'package:universal_cart/app/view/qr_scanner/widgets/scanner_button_widgets.dart';
import 'package:universal_cart/app/view/qr_scanner/widgets/scanner_error_widget.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:haptic_feedback/haptic_feedback.dart';

class BarcodeScannerWithController extends StatefulWidget {
  const BarcodeScannerWithController({super.key});

  @override
  State<BarcodeScannerWithController> createState() => _BarcodeScannerWithControllerState();
}

class _BarcodeScannerWithControllerState extends State<BarcodeScannerWithController> with WidgetsBindingObserver {
  late AudioPlayer player = AudioPlayer();
  final MobileScannerController controller = MobileScannerController(
    autoStart: false,
    torchEnabled: false,
    useNewCameraSelector: true,
  );

  Barcode? _barcode;
  StreamSubscription<Object?>? _subscription;

  Widget _buildBarcode(Barcode? value) {

    if (value == null) {
      return const Text(
        'Scan something!',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    /// Create the audio player.
    player = AudioPlayer();
    _subscription = controller.barcodes.listen(_handleBarcode);
    unawaited(controller.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.black,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: ColorPalette.white,
        leading: const Icon(Icons.arrow_back_ios_rounded, color: ColorPalette.liteOrange, size: 28),
        title: const Text(
          "Barcode Scanner",
          style: TextStyle(fontSize: 22, color: ColorPalette.black),
        ),
        centerTitle: false,
      ),
      body: BlocListener<BarcodeScannerBloc, BarcodeScannerState>(
        listener: (context, state) {
          if (state is HomeNavigateState) {
            Navigator.pop(context, state.product);
          }
        },
        child: Stack(
          children: [
            MobileScanner(
              controller: controller,
              onDetect: (barcodes) {
                if (mounted && (_barcode == null)) {
                  _barcode = barcodes.barcodes.firstOrNull;
                  beepSound(context: context);
                  context.read<BarcodeScannerBloc>().add(GetItem(itemId: _barcode?.displayValue ?? ""));
                } else {
                  log("Barcode Data: ${_barcode?.displayValue ?? "No Data"}");
                }
              },
              errorBuilder: (context, error, child) {
                return ScannerErrorWidget(error: error);
              },
              fit: BoxFit.contain,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                color: Colors.black.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ToggleFlashlightButton(controller: controller),
                    StartStopMobileScannerButton(controller: controller),
                    Expanded(child: Center(child: _buildBarcode(_barcode))),
                    SwitchCameraButton(controller: controller),
                    AnalyzeImageFromGalleryButton(controller: controller),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.dispose();
  }

  Future<void> beepSound({required BuildContext context}) async {
    // Check if device is capable of haptic feedback
    final can = await Haptics.canVibrate();

    // Show snackbar
    if (!context.mounted) return;
    can ? HapticFeedback.heavyImpact() : null;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item added", textAlign: TextAlign.center),
        duration: Duration(seconds: 1),
      ),
    );

    // Vibrate only if device is capable of haptic feedback
    if (!can) return;

    await Haptics.vibrate(HapticsType.soft);
    await player.play(AssetSource(Assets.beepSound));
    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);
  }
}
