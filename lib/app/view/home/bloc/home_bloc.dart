import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:universal_cart/app/model/cart_model.dart';
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
      List<Product> products = await shoppingRepository.loadCartAllItems();
      // final cartResponse = await shoppingRepository.loadCartItems();
      // products = cartResponse.products ?? [];
      // products += products;
      // products.shuffle();
      double totalPrice = 0;
      double totalDiscount = 0;

      for (var product in products) {
        totalPrice += product.price ?? 0;
        totalDiscount += product.discount ?? 0;
      }

      emit(CartLoaded(products: products, totalPrice: totalPrice, totalDiscount: totalDiscount));
    } catch (_) {
      emit(CartError());
    }
  }

  FutureOr<void> _onItemAdded(CartItemAdded event, Emitter<HomeState> emit) async {
    try {
      shoppingRepository.addItemToCart(event.item);
      List<Product> products = shoppingRepository.loadCartAllItems();
      double totalPrice = 0;
      double totalDiscount = 0;

      for (var product in products) {
        totalPrice += product.price ?? 0;
        totalDiscount += product.discount ?? 0;
      }

      emit(
        CartLoaded(
          products: [...products],
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
        List<Product> products = shoppingRepository.loadCartAllItems();
        double totalPrice = 0;
        double totalDiscount = 0;

        for (var product in products) {
          totalPrice += product.price ?? 0;
          totalDiscount += product.discount ?? 0;
        }

        emit(
          CartLoaded(
            products: [...products]..remove(event.item),
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
