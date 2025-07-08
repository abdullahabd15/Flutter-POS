import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/product.dart';
import 'package:pos/domain/repositories/product_repository.dart';

class EditProductUseCase {
  final ProductRepository repository;

  EditProductUseCase({required this.repository});

  Future<Either<FailureResponse, Product?>> execute(Product product) =>
      repository.editProduct(product);
}
