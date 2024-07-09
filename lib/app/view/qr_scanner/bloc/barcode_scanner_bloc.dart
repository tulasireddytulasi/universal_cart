import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:universal_cart/app/model/cart_model.dart';
import 'package:universal_cart/cart_repository.dart';

part 'barcode_scanner_event.dart';
part 'barcode_scanner_state.dart';

class BarcodeScannerBloc extends Bloc<BarcodeScannerEvent, BarcodeScannerState> {
  BarcodeScannerBloc({required this.shoppingRepository}) : super(BarcodeScannerInitial()) {
    on<ScannerStarted>(_onScannerStarted);
    on<GetItem>(_onGetItem);
  }

  final ShoppingRepository shoppingRepository;

  FutureOr<void> _onScannerStarted(ScannerStarted event, Emitter<BarcodeScannerState> emit) async {
    try {
      shoppingRepository.loadAllItems();
    } catch (e) {
      emit(ItemError());
    }
  }

  FutureOr<void> _onGetItem(GetItem event, Emitter<BarcodeScannerState> emit) async {
    try {
      shoppingRepository.removeAllItems();
      await shoppingRepository.loadAllItems();
      List<Product> productsList = shoppingRepository.loadCartAllItems();

      var products = productsList.where((product) => product.barcode == event.itemId);

      if (products.isNotEmpty) {
        Product foundProduct = products.first;
        log('Product found: ${foundProduct.name}, Price: ${foundProduct.price}');
        emit(HomeNavigateState(product: foundProduct));
      } else {
        log('Product not found');
      }
    } catch (e) {
      emit(ItemError());
    }
  }
}
