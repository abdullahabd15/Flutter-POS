import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/product.dart';
import 'package:pos/data/models/product_body.dart';
import 'package:pos/domain/repositories/product_repository.dart';

class AddProductUseCase {
  final ProductRepository repository;

  AddProductUseCase({required this.repository});

  Future<Either<FailureResponse, Product?>> execute(ProductBody product) =>
      repository.addProduct(product);
}
