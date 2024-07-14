part of 'barcode_scanner_bloc.dart';

@immutable
sealed class BarcodeScannerState extends Equatable {
  const BarcodeScannerState();
}

class BarcodeScannerInitial extends BarcodeScannerState {
  @override
  List<Object> get props => [];
}

final class ItemLoading extends BarcodeScannerState {
  @override
  List<Object> get props => [];
}

final class HomeNavigateState extends BarcodeScannerState {
  const HomeNavigateState({required this.product});
  final CartItemModel product;

  @override
  List<Object> get props => [product];
}

final class ItemError extends BarcodeScannerState {
  const ItemError({required this.errorModel});
  final ErrorModel errorModel;

  @override
  List<Object> get props => [errorModel];
}