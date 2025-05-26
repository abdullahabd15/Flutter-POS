import 'package:dependencies/json_annotation/json_annotation.dart';
import 'package:pos/data/models/transaction_item.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  final int? id;
  final String? dateTime;
  final double? totalPrice;
  final double? tax;
  final String? status;
  final List<TransactionItem>? items;

  Transaction({
    required this.id,
    required this.dateTime,
    required this.totalPrice,
    required this.tax,
    required this.status,
    required this.items,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
