import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:universal_cart/app/core/utils/assets_path.dart';
import 'package:universal_cart/app/model/cart_model.dart';

const _delay = Duration(milliseconds: 800);

class ShoppingRepository {

  final List<Product> _products = <Product>[];

  Future<void> loadAllItems() async {
    final String response = await rootBundle.loadString(Assets.productsJSONObject);
    final data = await json.decode(response);
    final CartModel cartResponse = CartModel.fromJson(data);
    _products.addAll(cartResponse.products ?? []);
  }

  Future<CartModel> loadCartItems() async {
    final String response = await rootBundle.loadString(Assets.productsJSONObject);
    final data = await json.decode(response);
    final CartModel cartResponse = CartModel.fromJson(data);
    Future.delayed(_delay);
    return cartResponse;
  }

  List<Product> loadCartAllItems() => _products;

  void removeAllItems() => _products.clear();

  void addItemToCart(Product item) => _products.add(item);

  void removeItemFromCart(Product item) => _products.remove(item);
}