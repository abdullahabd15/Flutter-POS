import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/datasources/product_data_source.dart';
import 'package:pos/data/models/product.dart';
import 'package:pos/data/models/product_body.dart';
import 'package:pos/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductDataSource productDataSource;

  ProductRepositoryImpl({required this.productDataSource});

  @override
  Future<Either<FailureResponse, List<Product>>> fetchProducts() async {
    try {
      final result = await productDataSource.fetchProducts();
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
  Future<Either<FailureResponse, Product?>> addProduct(
      ProductBody product) async {
    try {
      final result = await productDataSource.addProduct(product);
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
  Future<Either<FailureResponse, String?>> deleteProduct(int? id) async {
    try {
      final result = await productDataSource.deleteProduct(id);
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
  Future<Either<FailureResponse, Product?>> editProduct(
    int? id,
    ProductBody product,
  ) async {
    try {
      final result = await productDataSource.editProduct(id, product);
      if (result.success == true && result.data != null) {
        return Right(result.data!);
      } else {
        return const Left(FailureResponse(message: 'Something went wrong'));
      }
    } catch (e) {
      return Left(FailureResponse(message: e.toString()));
    }
  }
}
