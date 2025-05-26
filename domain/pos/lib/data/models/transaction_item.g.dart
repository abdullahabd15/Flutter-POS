// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionItem _$TransactionItemFromJson(Map<String, dynamic> json) =>
    TransactionItem(
      transactionId: (json['transactionId'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      qty: (json['qty'] as num?)?.toInt(),
      name: json['name'] as String?,
      imagePath: json['imagePath'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TransactionItemToJson(TransactionItem instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'productId': instance.productId,
      'qty': instance.qty,
      'name': instance.name,
      'imagePath': instance.imagePath,
      'price': instance.price,
      'total': instance.total,
    };
