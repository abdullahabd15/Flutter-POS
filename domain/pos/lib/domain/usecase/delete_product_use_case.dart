import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/domain/repositories/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository repository;

  DeleteProductUseCase({required this.repository});

  Future<Either<FailureResponse, String?>> execute(int? id) =>
      repository.deleteProduct(id);
}
