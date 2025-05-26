import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/cart.dart';
import 'package:pos/domain/repositories/pos_repository.dart';

class FetchShoppingCartUseCase {
  final PosRepository repository;

  const FetchShoppingCartUseCase({required this.repository});

  Future<Either<FailureResponse, Cart>> execute() =>
      repository.fetchShoppingCart();
}
