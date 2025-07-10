import 'package:dependencies/json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'product_body.g.dart';

@JsonSerializable()
class ProductBody {
  final String name;
  final String category;
  final double price;
  final int stock;
  final Uint8List? image;
  final String? imageName;
  final String? description;

  ProductBody({
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    this.image,
    this.imageName,
    this.description,
  });

  Map<String, dynamic> toJson() => _$ProductBodyToJson(this);
}
