import 'package:dependencies/json_annotation/json_annotation.dart';
import 'package:pos/data/models/checkout_item_body.dart';

part 'checkout_body.g.dart';

@JsonSerializable()
class CheckoutBody {
  final int? cartId;
  final List<CheckoutItemBody> items;

  CheckoutBody({
    required this.cartId,
    required this.items,
  });

  Map<String, dynamic> toJson() => _$CheckoutBodyToJson(this);
}
