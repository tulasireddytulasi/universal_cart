import 'package:equatable/equatable.dart';
import 'package:universal_cart/app/model/cart_model.dart';

class CartItemModel extends Equatable {
  final String name;
  final double finalPrice;
  final double finalDiscount;
  final int noOfItems;
  final Product itemData;

  const CartItemModel({
    required this.name,
    required this.finalPrice,
    required this.finalDiscount,
    required this.noOfItems,
    required this.itemData,
  });

  @override
  List<Object> get props => [name, finalPrice, finalDiscount, noOfItems, itemData];
}