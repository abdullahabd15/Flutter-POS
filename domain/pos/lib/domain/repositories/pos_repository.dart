import 'package:common/error/failure_response.dart';
import 'package:core/network/api_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/checkout_body.dart';
import 'package:pos/data/models/login_result.dart';
import 'package:pos/data/models/transaction.dart';

import '../../data/models/cart.dart';
import '../../data/models/product.dart';
import '../../data/models/product_category.dart';

abstract class PosRepository {
  Future<Either<FailureResponse, List<ProductCategory>>>
      fetchProductCategories();

  Future<Either<FailureResponse, List<Product>>> fetchProducts();

  Future<Either<FailureResponse, Cart>> fetchShoppingCart();

  Future<Either<FailureResponse, Cart>> addItemToCart(int? productId, int qty);

  Future<Either<FailureResponse, Cart>> deleteItemCart(int? productId);

  Future<Either<FailureResponse, Cart>> clearItemsCart();

  Future<Either<FailureResponse, Transaction>> checkout(CheckoutBody body);

  Future<Either<FailureResponse, List<Transaction>>> fetchTransactionsHistory({
    String? fromDate,
    String? toDate,
  });

  Future<Either<FailureResponse, ProductCategory?>> addCategory(String name);

  Future<Either<FailureResponse, ProductCategory?>> editCategory(int? id, String name);

  Future<Either<FailureResponse, String?>> deleteCategory(int? id);

  Future<Either<FailureResponse, LoginResult>> login(String username, String password);

  Future<Either<FailureResponse, ApiResponse<dynamic>>> logout();
}
