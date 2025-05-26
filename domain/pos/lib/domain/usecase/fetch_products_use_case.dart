import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/product.dart';
import 'package:pos/domain/repositories/pos_repository.dart';

class FetchProductsUseCase {
  final PosRepository repository;

  const FetchProductsUseCase({required this.repository});

  Future<Either<FailureResponse, List<Product>>> execute() async =>
      repository.fetchProducts();
}
