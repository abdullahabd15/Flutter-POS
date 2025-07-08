import 'package:common/extension/extension.dart';
import 'package:core/network/api_response.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:pos/data/models/cart.dart';
import 'package:pos/data/models/cart_body.dart';
import 'package:pos/data/models/checkout_body.dart';
import 'package:pos/data/models/transaction.dart';

abstract class PosDataSource {
  Future<ApiResponse<Cart>> fetchShoppingCart();

  Future<ApiResponse<Cart>> addItemToCart(int? productId, int qty);

  Future<ApiResponse<Cart>> deleteItemCart(int? productId);

  Future<ApiResponse<Cart>> clearItemsCart();

  Future<ApiResponse<Transaction>> checkout(CheckoutBody body);

  Future<ApiResponse<List<Transaction>>> fetchTransactionsHistory({
    String? fromDate,
    String? toDate,
  });
}

class PosDataSourceImpl extends PosDataSource {
  final Dio dio;
  final SharedPreferences prefs;

  PosDataSourceImpl({required this.dio, required this.prefs});

  Options _options() {
    return Options(
      headers: {
        'Authorization': 'Bearer ${prefs.getToken()}',
      },
    );
  }

  @override
  Future<ApiResponse<Cart>> addItemToCart(int? productId, int qty) async {
    try {
      final body = CartBody(productId: productId, qty: qty).toJson();
      final response = await dio.patch(
        '/cart',
        data: body,
        options: _options(),
      );
      return ApiResponse.fromJson(
          response.data, (json) => Cart.fromJson(json as Map<String, dynamic>));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<Cart>> clearItemsCart() async {
    try {
      final response =
          await dio.delete('/cart/delete-all', options: _options());
      return ApiResponse.fromJson(
          response.data, (json) => Cart.fromJson(json as Map<String, dynamic>));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<Cart>> deleteItemCart(int? productId) async {
    try {
      final response =
          await dio.delete('/cart/$productId', options: _options());
      return ApiResponse.fromJson(
          response.data, (json) => Cart.fromJson(json as Map<String, dynamic>));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<Cart>> fetchShoppingCart() async {
    try {
      final response = await dio.get('/cart', options: _options());
      return ApiResponse.fromJson(
        response.data,
        (json) => Cart.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<Transaction>> checkout(CheckoutBody body) async {
    try {
      final response = await dio.post('/transactions/checkout',
          data: body.toJson(), options: _options());
      return ApiResponse.fromJson(
        response.data,
        (json) => Transaction.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<Transaction>>> fetchTransactionsHistory({
    String? fromDate,
    String? toDate,
  }) async {
    try {
      final params = fromDate != null && toDate != null
          ? {
              'fromDate': fromDate,
              'toDate': toDate,
            }
          : null;
      final response = await dio.get(
        '/transactions/history',
        queryParameters: params,
        options: _options(),
      );
      return ApiResponse.fromJson(
        response.data,
        (json) => (json as List<dynamic>)
            .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
