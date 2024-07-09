part of 'barcode_scanner_bloc.dart';

@immutable
sealed class BarcodeScannerEvent extends Equatable {
  const BarcodeScannerEvent();
}

final class ScannerStarted extends BarcodeScannerEvent {
  @override
  List<Object> get props => [];
}

final class GetItem extends BarcodeScannerEvent {
  const GetItem({required this.itemId});

  final String itemId;

  @override
  List<Object> get props => [itemId];
}