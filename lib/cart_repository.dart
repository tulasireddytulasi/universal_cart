import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:universal_cart/app/core/utils/assets_path.dart';
import 'package:universal_cart/app/model/cart_item_model.dart';
import 'package:universal_cart/app/model/cart_model.dart';

const _delay = Duration(milliseconds: 800);

class ShoppingRepository {

  final List<CartItemModel> _allProductsList = <CartItemModel>[];

  final List<CartItemModel> _cartItems = <CartItemModel>[];

  Future<void> fetchAllItems() async {
    if(_allProductsList.isEmpty){
      final String response = await rootBundle.loadString(Assets.productsJSONObject);
      final data = await json.decode(response);
      final CartModel cartResponse = CartModel.fromJson(data);
      for(Product product in cartResponse.products ?? []){
        _allProductsList.add(CartItemModel(
          name: product.name ?? "",
          finalPrice: product.price?.toDouble() ?? 0,
          finalDiscount: product.discount?.toDouble() ?? 0,
          noOfItems: 1,
          itemData: product,
        ));
      }
    }
  }

  Future<CartItemModel> fetchItem({required String itemId}) async {
    await fetchAllItems();
    CartItemModel cartItem = _allProductsList.firstWhere((product) => product.itemData.barcode == itemId);
    return cartItem;
  }

  Future<bool> isItemFound({required String itemId}) async {
    await fetchAllItems();
    bool itemFound = _allProductsList.any((model) => model.itemData.barcode == itemId);
    return itemFound;
  }

  List<CartItemModel> loadCartAllItems() => _cartItems;

  void removeAllItems() => _cartItems.clear();

  void addItemToCart(CartItemModel item) => _cartItems.insert(0, item);

  void removeItemFromCart(CartItemModel item) => _cartItems.remove(item);
}
