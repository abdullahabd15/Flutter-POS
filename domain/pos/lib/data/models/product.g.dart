// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] == null ? null : int.tryParse(json['id'].toString()),
      name: json['name'] as String?,
      category: json['category'] as String?,
      price: json['price'] == null ? null : double.tryParse(json['price'].toString()),
      stock: json['stock'] == null ? null : int.tryParse(json['stock'].toString()),
      description: json['description'] as String?,
      imageName: json['image_name'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'price': instance.price,
      'stock': instance.stock,
      'description': instance.description,
      'image_name': instance.imageName,
    };
