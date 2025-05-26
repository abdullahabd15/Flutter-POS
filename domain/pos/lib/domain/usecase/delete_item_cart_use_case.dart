import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/cart.dart';
import 'package:pos/domain/repositories/pos_repository.dart';

class DeleteItemCartUseCase {
  final PosRepository repository;

  const DeleteItemCartUseCase({required this.repository});

  Future<Either<FailureResponse, Cart>> execute(int? productId) =>
      repository.deleteItemCart(productId);
}
