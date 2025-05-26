import 'package:dependencies/equatable/equatable.dart';
import 'package:pos/data/models/transaction.dart';

class TransactionsState extends Equatable {
  final Transaction? transaction;

  const TransactionsState({
    required this.transaction,
  });

  TransactionsState copyWith({
    Transaction? transaction,
    List<Transaction>? transactionsHistory,
  }) {
    return TransactionsState(
      transaction: transaction ?? this.transaction,
    );
  }

  @override
  List<Object?> get props => [transaction];
}
