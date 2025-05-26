// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: (json['id'] as num?)?.toInt(),
      dateTime: json['dateTime'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      tax: (json['tax'] as num?)?.toDouble(),
      status: json['status'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => TransactionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dateTime': instance.dateTime,
      'totalPrice': instance.totalPrice,
      'tax': instance.tax,
      'status': instance.status,
      'items': instance.items,
    };
