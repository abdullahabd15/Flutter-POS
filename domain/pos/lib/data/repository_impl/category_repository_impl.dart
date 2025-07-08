import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/datasources/category_data_source.dart';
import 'package:pos/data/models/product_category.dart';
import 'package:pos/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDataSource categoryDataSource;

  CategoryRepositoryImpl({required this.categoryDataSource});

  @override
  Future<Either<FailureResponse, List<ProductCategory>>>
      fetchProductCategories() async {
    try {
      final result = await categoryDataSource.fetchProductCategories();
      if (result.success == true && result.data != null) {
        return Right(result.data!);
      } else {
        return const Left(FailureResponse(message: 'Something went wrong'));
      }
    } catch (e) {
      return Left(FailureResponse(message: e.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, ProductCategory?>> addCategory(
      String name) async {
    try {
      final result = await categoryDataSource.addCategory(name);
      if (result.success == true) {
        return Right(result.data);
      } else {
        return const Left(FailureResponse(message: 'Something went wrong'));
      }
    } catch (e) {
      return Left(FailureResponse(message: e.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, ProductCategory?>> editCategory(
    int? id,
    String name,
  ) async {
    try {
      final result = await categoryDataSource.editCategory(id, name);
      if (result.success == true) {
        return Right(result.data);
      } else {
        return const Left(FailureResponse(message: 'Something went wrong'));
      }
    } catch (e) {
      return Left(FailureResponse(message: e.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, String?>> deleteCategory(int? id) async {
    try {
      final result = await categoryDataSource.deleteCategory(id);
      if (result.success == true) {
        return Right(result.data);
      } else {
        return const Left(FailureResponse(message: 'Something went wrong'));
      }
    } catch (e) {
      return Left(FailureResponse(message: e.toString()));
    }
  }
}
