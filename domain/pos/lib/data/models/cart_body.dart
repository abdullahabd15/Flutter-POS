import 'package:dependencies/json_annotation/json_annotation.dart';

part 'cart_body.g.dart';

@JsonSerializable()
class CartBody {
  final int? productId;
  final int qty;

  CartBody({required this.productId, required this.qty});

  Map<String, dynamic> toJson() => _$CartBodyToJson(this);
}
