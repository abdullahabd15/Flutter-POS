import 'package:dependencies/json_annotation/json_annotation.dart';

part 'transaction_item.g.dart';

@JsonSerializable()
class TransactionItem {
  final int? transactionId;
  final int? productId;
  final int? qty;
  final String? name;
  final String? imagePath;
  final double? price;
  final double? total;

  TransactionItem({
    required this.transactionId,
    required this.productId,
    required this.qty,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.total,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionItemToJson(this);
}
