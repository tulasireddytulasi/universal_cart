import 'dart:async';
import 'dart:developer' as logg;
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
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
        /// Here we are Random key for to emit new state,
        /// if product object was same new state will not emit
        var key = Random();
        final String keyVal = key.nextInt(100000).toString();
        logg.log('Product found: ${foundProduct.name}, Price: ${foundProduct.price}, key: $keyVal');
        Product foundProduct1 = Product(barcode: foundProduct.barcode, totalPrice: foundProduct.totalPrice, price: foundProduct.price,
        brand: foundProduct.brand, description: foundProduct.description, discount: foundProduct.discount, finalPrice: foundProduct.finalPrice, inventoryStatus: keyVal,
        location: foundProduct.location, name: foundProduct.name, productId: foundProduct.productId, weight: foundProduct.weight, quantity: foundProduct.quantity,
        paymentMethod: foundProduct.paymentMethod);
        emit(HomeNavigateState(product: foundProduct1));
      } else {
        logg.log('Product not found');
      }
    } catch (e) {
      emit(ItemError());
    }
  }
}
