import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/product_category.dart';
import 'package:pos/domain/repositories/pos_repository.dart';

class FetchProductCategoriesUseCase {
  final PosRepository repository;

  const FetchProductCategoriesUseCase({required this.repository});

  Future<Either<FailureResponse, List<ProductCategory>>> execute() =>
      repository.fetchProductCategories();
}
