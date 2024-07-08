part of 'barcode_scanner_bloc.dart';

sealed class BarcodeScannerState extends Equatable {
  const BarcodeScannerState();
}

class BarcodeScannerInitial extends BarcodeScannerState {
  @override
  List<Object> get props => [];
}
