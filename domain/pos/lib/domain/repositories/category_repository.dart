import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/product_category.dart';

abstract class CategoryRepository {
  Future<Either<FailureResponse, List<ProductCategory>>>
      fetchProductCategories();

  Future<Either<FailureResponse, ProductCategory?>> addCategory(String name);

  Future<Either<FailureResponse, ProductCategory?>> editCategory(
    int? id,
    String name,
  );

  Future<Either<FailureResponse, String?>> deleteCategory(int? id);
}
