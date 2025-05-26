// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartBody _$CartBodyFromJson(Map<String, dynamic> json) => CartBody(
      productId: (json['productId'] as num?)?.toInt(),
      qty: (json['qty'] as num).toInt(),
    );

Map<String, dynamic> _$CartBodyToJson(CartBody instance) => <String, dynamic>{
      'productId': instance.productId,
      'qty': instance.qty,
    };
