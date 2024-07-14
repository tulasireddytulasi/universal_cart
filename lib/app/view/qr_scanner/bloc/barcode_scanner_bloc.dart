import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:universal_cart/app/model/cart_item_model.dart';
import 'package:universal_cart/app/model/error_model.dart';
import 'package:universal_cart/cart_repository.dart';

part 'barcode_scanner_event.dart';

part 'barcode_scanner_state.dart';

class BarcodeScannerBloc extends Bloc<BarcodeScannerEvent, BarcodeScannerState> {
  BarcodeScannerBloc({required this.shoppingRepository}) : super(BarcodeScannerInitial()) {
    on<GetItem>(_onGetItem);
  }

  final ShoppingRepository shoppingRepository;

  FutureOr<void> _onGetItem(GetItem event, Emitter<BarcodeScannerState> emit) async {
    try {
      final bool itemFound = await shoppingRepository.isItemFound(itemId: event.itemId);

      if (!itemFound) {
        ErrorModel errorModel = ErrorModel(errorMessage: "Item not found", dateTime: DateTime.now().toIso8601String());
        emit(ItemError(errorModel: errorModel));
        return;
      }

      CartItemModel cartItem = await shoppingRepository.fetchItem(itemId: event.itemId);

      List<CartItemModel> productsList = shoppingRepository.loadCartAllItems();

      if (productsList.isEmpty) {
        emit(HomeNavigateState(product: cartItem));
        return;
      }

      bool duplicateItem = productsList.any((model) => model.name.trim().toLowerCase() == cartItem.name.trim().toLowerCase());
      if (duplicateItem) {
        CartItemModel cartItem2 = productsList.firstWhere((product) => product.name == cartItem.name);
        final int quantity = 1 + cartItem2.noOfItems;
        final CartItemModel itemModel = CartItemModel(
          name: cartItem.name,
          finalPrice: cartItem.finalPrice,
          finalDiscount: cartItem.finalDiscount,
          noOfItems: quantity,
          itemData: cartItem.itemData,
        );
        emit(HomeNavigateState(product: itemModel));
      } else {
        emit(HomeNavigateState(product: cartItem));
      }
    } catch (e, t) {
      ErrorModel errorModel = ErrorModel(errorMessage: e.toString(), dateTime: DateTime.now().toIso8601String());
      emit(ItemError(errorModel: errorModel));
    }
  }
}
