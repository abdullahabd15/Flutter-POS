import 'package:dependencies/json_annotation/json_annotation.dart';

import 'item_cart.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  final int? id;
  final String? orderId;
  final double? subtotal;
  final double? tax;
  final int? taxPercentage;
  final double? total;
  final List<ItemCart>? items;

  Cart({
    required this.id,
    required this.orderId,
    required this.subtotal,
    required this.tax,
    required this.taxPercentage,
    required this.total,
    required this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
