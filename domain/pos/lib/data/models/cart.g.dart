// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: (json['id'] as num?)?.toInt(),
      orderId: json['orderId'] as String?,
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      tax: (json['tax'] as num?)?.toDouble(),
      taxPercentage: (json['taxPercentage'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toDouble(),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemCart.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'subtotal': instance.subtotal,
      'tax': instance.tax,
      'taxPercentage': instance.taxPercentage,
      'total': instance.total,
      'items': instance.items,
    };
