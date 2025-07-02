import 'package:common/error/api_exception.dart';
import 'package:common/error/failure_response.dart';
import 'package:core/network/api_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/datasources/pos_data_source.dart';
import 'package:pos/data/models/cart.dart';
import 'package:pos/data/models/checkout_body.dart';
import 'package:pos/data/models/login_result.dart';
import 'package:pos/data/models/product.dart';
import 'package:pos/data/models/product_category.dart';
import 'package:pos/data/models/transaction.dart';
import 'package:pos/domain/repositories/pos_repository.dart';

class PosRepositoryImpl extends PosRepository {
  final PosDataSource posDataSource;

  PosRepositoryImpl({required this.posDataSource});

  @override
  Future<Either<FailureResponse, Cart>> addItemToCart(
    int? productId,
    int qty,
  ) async {
    try {
      final result = await posDataSource.addItemToCart(productId, qty);
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
  Future<Either<FailureResponse, Cart>> clearItemsCart() async {
    try {
      final result = await posDataSource.clearItemsCart();
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
  Future<Either<FailureResponse, Cart>> deleteItemCart(int? productId) async {
    try {
      final result = await posDataSource.deleteItemCart(productId);
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
  Future<Either<FailureResponse, List<ProductCategory>>>
      fetchProductCategories() async {
    try {
      final result = await posDataSource.fetchProductCategories();
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
  Future<Either<FailureResponse, List<Product>>> fetchProducts() async {
    try {
      final result = await posDataSource.fetchProducts();
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
  Future<Either<FailureResponse, Cart>> fetchShoppingCart() async {
    try {
      final result = await posDataSource.fetchShoppingCart();
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
  Future<Either<FailureResponse, Transaction>> checkout(
    CheckoutBody body,
  ) async {
    try {
      final result = await posDataSource.checkout(body);
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
  Future<Either<FailureResponse, List<Transaction>>> fetchTransactionsHistory({
    String? fromDate,
    String? toDate,
  }) async {
    try {
      final result = await posDataSource.fetchTransactionsHistory(
        fromDate: fromDate,
        toDate: toDate,
      );
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
  Future<Either<FailureResponse, LoginResult>> login(String username, String password) async {
    try {
      final result = await posDataSource.login(username, password);
      if (result.success == true) {
        return Right(result);
      } else {
        return const Left(FailureResponse(message: 'Something went wrong'));
      }
    } on ApiException catch (e) {
      return Left(FailureResponse(message: e.message));
    } catch (e) {
      return Left(FailureResponse(message: e.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, ApiResponse<Object>>> logout() async {
    try {
      final result = await posDataSource.logout();
      if (result.success == true && result.data != null) {
        return Right(result);
      } else {
        return const Left(FailureResponse(message: 'Something went wrong'));
      }
    } catch (e) {
      return Left(FailureResponse(message: e.toString()));
    }
  }
}
