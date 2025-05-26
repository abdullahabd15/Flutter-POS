import 'package:dependencies/json_annotation/json_annotation.dart';

part 'checkout_item_body.g.dart';

@JsonSerializable()
class CheckoutItemBody {
  final int? productId;
  final int qty;

  CheckoutItemBody({
    required this.productId,
    required this.qty,
  });

  Map<String, dynamic> toJson() => _$CheckoutItemBodyToJson(this);


}
