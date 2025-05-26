import 'package:dependencies/equatable/equatable.dart';
import 'package:pos/data/models/transaction.dart';

class TransactionsState extends Equatable {
  final List<Transaction> transactionHistory;

  const TransactionsState({
    required this.transactionHistory,
  });

  TransactionsState copyWith({
    List<Transaction>? transactionHistory,
  }) {
    return TransactionsState(
      transactionHistory: transactionHistory ?? this.transactionHistory,
    );
  }

  @override
  List<Object?> get props => [transactionHistory];
}
