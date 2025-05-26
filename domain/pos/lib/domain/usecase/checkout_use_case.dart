import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/checkout_body.dart';
import 'package:pos/data/models/transaction.dart';
import 'package:pos/domain/repositories/pos_repository.dart';

class CheckoutUseCase {
  final PosRepository repository;

  const CheckoutUseCase({required this.repository});

  Future<Either<FailureResponse, Transaction>> execute(CheckoutBody body) =>
      repository.checkout(body);
}
