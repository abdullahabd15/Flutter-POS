// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemCart _$ItemCartFromJson(Map<String, dynamic> json) => ItemCart(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      imagePath: json['imagePath'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemCartToJson(ItemCart instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'name': instance.name,
      'price': instance.price,
      'imagePath': instance.imagePath,
      'qty': instance.qty,
    };
