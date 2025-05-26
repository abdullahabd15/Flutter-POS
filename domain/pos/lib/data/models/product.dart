import 'package:dependencies/json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int? id;
  final String? name;
  final String? category;
  final double? price;
  final int? stock;
  final String? description;
  final String? imagePath;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.description,
    required this.imagePath,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
