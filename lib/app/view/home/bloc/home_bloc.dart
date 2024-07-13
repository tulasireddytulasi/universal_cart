import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:universal_cart/app/model/cart_item_model.dart';
import 'package:universal_cart/cart_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.shoppingRepository}) : super(HomeInitial()) {
    on<CartStarted>(_onStarted);
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
  }

  final ShoppingRepository shoppingRepository;

  FutureOr<void> _onStarted(CartStarted event, Emitter<HomeState> emit) async {
    emit(CartLoading());
    try {
      List<CartItemModel> products = shoppingRepository.loadCartAllItems();
      double totalPrice = 0;
      double totalDiscount = 0;
      int quantity = 0;

      for (var product in products) {
        totalPrice += product.finalPrice;
        totalDiscount += product.finalDiscount;
        quantity += product.noOfItems;
      }

      emit(CartLoaded(
        products: products,
        quantity: quantity,
        totalPrice: totalPrice,
        totalDiscount: totalDiscount,
      ));
    } catch (_) {
      emit(CartError());
    }
  }

  FutureOr<void> _onItemAdded(CartItemAdded event, Emitter<HomeState> emit) async {
    try {
      List<CartItemModel> products = shoppingRepository.loadCartAllItems();

      /// Find the whether the item already exists or not
      bool duplicateItem = products.any((model) => model.name.trim().toLowerCase() == event.item.name.trim().toLowerCase());
      if(products.isNotEmpty && duplicateItem){
        duplicateItem = true;

        /// Get the item where the name is equal to event.item.name
        CartItemModel cartItemModel = products.firstWhere((model) => model.name == event.item.name);

        final CartItemModel itemModel = CartItemModel(
          name: cartItemModel.name,
          finalPrice: cartItemModel.finalPrice + (event.item.itemData.price ?? 0),
          finalDiscount: cartItemModel.finalDiscount + (event.item.itemData.discount ?? 0),
          noOfItems: event.item.noOfItems,
          itemData: event.item.itemData,
        );

        // Delete the item from the cart
        shoppingRepository.removeItemFromCart(cartItemModel);

        // Add latest Item into cart
        shoppingRepository.addItemToCart(itemModel);
      } else {
        shoppingRepository.addItemToCart(event.item);
      }
      double totalPrice = 0;
      double totalDiscount = 0;
      int quantity = 0;

      products = shoppingRepository.loadCartAllItems();

      for (var product in products) {
        totalPrice += product.finalPrice;
        totalDiscount += product.finalDiscount;
        quantity += product.noOfItems;
      }

      emit(
        CartLoaded(
          products: [...products],
          quantity: quantity,
          totalPrice: totalPrice,
          totalDiscount: totalDiscount,
        ),
      );
    } catch (e, s) {
      log("_onItemAdded Error: $e");
      log("_onItemAdded Stack Error: $s");
      emit(CartError());
    }
  }

  FutureOr<void> _onItemRemoved(CartItemRemoved event, Emitter<HomeState> emit) async {
    try {
      final state = this.state;
      if (state is CartLoaded) {
        shoppingRepository.removeItemFromCart(event.item);
        List<CartItemModel> products = shoppingRepository.loadCartAllItems();
        double totalPrice = 0;
        double totalDiscount = 0;
        int quantity = 0;

        for (var product in products) {
          totalPrice += product.finalPrice;
          totalDiscount += product.finalDiscount;
          quantity += product.noOfItems;
        }

        emit(
          CartLoaded(
            products: [...products]..remove(event.item),
            quantity: quantity,
            totalPrice: totalPrice,
            totalDiscount: totalDiscount,
          ),
        );
      }
    } catch (e, s) {
      log("_onItemRemoved Error: $e");
      log("_onItemRemoved Stack Error: $s");
      emit(CartError());
    }
  }
}
