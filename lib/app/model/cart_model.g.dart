// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartModelImpl _$$CartModelImplFromJson(Map<String, dynamic> json) =>
    _$CartModelImpl(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CartModelImplToJson(_$CartModelImpl instance) =>
    <String, dynamic>{
      'products': instance.products,
    };

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      barcode: json['barcode'] as String?,
      productId: json['productId'] as String?,
      name: json['name'] as String?,
      brand: json['brand'] as String?,
      description: json['description'] as String?,
      weight: json['weight'] as String?,
      price: (json['price'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      finalPrice: (json['finalPrice'] as num?)?.toInt(),
      inventoryStatus: json['inventoryStatus'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      location: json['location'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
      paymentMethod: json['paymentMethod'] as String?,
      loyaltyPointsEarned: (json['loyaltyPointsEarned'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'barcode': instance.barcode,
      'productId': instance.productId,
      'name': instance.name,
      'brand': instance.brand,
      'description': instance.description,
      'weight': instance.weight,
      'price': instance.price,
      'discount': instance.discount,
      'finalPrice': instance.finalPrice,
      'inventoryStatus': instance.inventoryStatus,
      'timestamp': instance.timestamp?.toIso8601String(),
      'location': instance.location,
      'quantity': instance.quantity,
      'totalPrice': instance.totalPrice,
      'paymentMethod': instance.paymentMethod,
      'loyaltyPointsEarned': instance.loyaltyPointsEarned,
    };
