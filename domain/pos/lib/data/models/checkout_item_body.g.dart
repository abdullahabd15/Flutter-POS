// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_item_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutItemBody _$CheckoutItemBodyFromJson(Map<String, dynamic> json) =>
    CheckoutItemBody(
      productId: (json['productId'] as num?)?.toInt(),
      qty: (json['qty'] as num).toInt(),
    );

Map<String, dynamic> _$CheckoutItemBodyToJson(CheckoutItemBody instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'qty': instance.qty,
    };
