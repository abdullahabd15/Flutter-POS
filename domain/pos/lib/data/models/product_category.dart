import 'package:dependencies/json_annotation/json_annotation.dart';

part 'product_category.g.dart';

@JsonSerializable()
class ProductCategory {
  final int? id;
  final String? name;
  final int? itemCount;

  ProductCategory({
    required this.id,
    required this.name,
    required this.itemCount,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);
}
