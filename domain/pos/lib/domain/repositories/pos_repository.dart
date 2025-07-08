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

  Future<Either<FailureResponse, Cart>> fetchShoppingCart();

  Future<Either<FailureResponse, Cart>> addItemToCart(int? productId, int qty);

  Future<Either<FailureResponse, Cart>> deleteItemCart(int? productId);

  Future<Either<FailureResponse, Cart>> clearItemsCart();

  Future<Either<FailureResponse, Transaction>> checkout(CheckoutBody body);

  Future<Either<FailureResponse, List<Transaction>>> fetchTransactionsHistory({
    String? fromDate,
    String? toDate,
  });
}
