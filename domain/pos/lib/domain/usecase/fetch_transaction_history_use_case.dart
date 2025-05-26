import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/transaction.dart';
import 'package:pos/domain/repositories/pos_repository.dart';

class FetchTransactionHistoryUseCase {
  final PosRepository repository;

  FetchTransactionHistoryUseCase({required this.repository});

  Future<Either<FailureResponse, List<Transaction>>> execute({
    String? fromDate,
    String? toDate,
  }) =>
      repository.fetchTransactionsHistory(
        fromDate: fromDate,
        toDate: toDate,
      );
}
