import 'package:dependencies/json_annotation/json_annotation.dart';

part 'product_body.g.dart';

@JsonSerializable()
class ProductBody {
  final String name;
  final String category;
  final double price;
  final int stock;

  ProductBody({
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
  });

  Map<String, dynamic> toJson() => _$ProductBodyToJson(this);
}
