// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      category: json['category'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      stock: (json['stock'] as num?)?.toInt(),
      description: json['description'] as String?,
      imagePath: json['imagePath'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'price': instance.price,
      'stock': instance.stock,
      'description': instance.description,
      'imagePath': instance.imagePath,
    };
