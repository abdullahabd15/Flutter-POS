import 'package:dependencies/json_annotation/json_annotation.dart';

part 'item_cart.g.dart';

@JsonSerializable()
class ItemCart {
  final int? id;
  final int? productId;
  final String? name;
  final double? price;
  final String? imagePath;
  final int? qty;

  ItemCart({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.qty,
  });

  factory ItemCart.fromJson(Map<String, dynamic> json) =>
      _$ItemCartFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCartToJson(this);
}
