import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class CartModel with _$CartModel {
  const factory CartModel({
    List<Product>? products,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
}

@freezed
class Product with _$Product{
  const factory Product({
    String? barcode,
    String? productId,
    String? name,
    String? brand,
    String? description,
    String? weight,
    int? price,
    int? discount,
    int? finalPrice,
    String? inventoryStatus,
    DateTime? timestamp,
    String? location,
    int? quantity,
    int? totalPrice,
    String? paymentMethod,
    int? loyaltyPointsEarned,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
