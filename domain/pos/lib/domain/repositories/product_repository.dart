import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/product.dart';
import 'package:pos/data/models/product_body.dart';

abstract class ProductRepository {
  Future<Either<FailureResponse, List<Product>>> fetchProducts();

  Future<Either<FailureResponse, Product?>> addProduct(ProductBody product);

  Future<Either<FailureResponse, Product?>> editProduct(Product product);

  Future<Either<FailureResponse, String?>> deleteProduct(int? id);
}
