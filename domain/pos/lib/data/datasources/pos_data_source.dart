import 'package:common/extension/extension.dart';
import 'package:core/network/api_response.dart';
import 'package:common/error/api_exception.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:pos/data/models/cart.dart';
import 'package:pos/data/models/cart_body.dart';
import 'package:pos/data/models/checkout_body.dart';
import 'package:pos/data/models/login_result.dart';
import 'package:pos/data/models/product.dart';
import 'package:pos/data/models/product_category.dart';
import 'package:pos/data/models/transaction.dart';

abstract class PosDataSource {
  Future<ApiResponse<List<ProductCategory>>> fetchProductCategories();

  Future<ApiResponse<List<Product>>> fetchProducts();

  Future<ApiResponse<Cart>> fetchShoppingCart();

  Future<ApiResponse<Cart>> addItemToCart(int? productId, int qty);

  Future<ApiResponse<Cart>> deleteItemCart(int? productId);

  Future<ApiResponse<Cart>> clearItemsCart();

  Future<ApiResponse<Transaction>> checkout(CheckoutBody body);

  Future<ApiResponse<List<Transaction>>> fetchTransactionsHistory({
    String? fromDate,
    String? toDate,
  });

  Future<ApiResponse<ProductCategory?>> addCategory(String name);

  Future<ApiResponse<ProductCategory?>> editCategory(int? id, String name);

  Future<ApiResponse<String?>> deleteCategory(int? id);

  Future<LoginResult> login(String username, String password);

  Future<ApiResponse<dynamic>> logout();
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
  Future<ApiResponse<List<ProductCategory>>> fetchProductCategories() async {
    try {
      final response = await dio.get('/categories', options: _options());
      return ApiResponse<List<ProductCategory>>.fromJson(
        response.data,
        (json) => (json as List<dynamic>)
            .map((e) => ProductCategory.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<Product>>> fetchProducts() async {
    try {
      final response = await dio.get('/products', options: _options());
      return ApiResponse.fromJson(
        response.data,
        (json) => (json as List<dynamic>)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
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
  Future<ApiResponse<ProductCategory?>> addCategory(String name) async {
    try {
      final response = await dio.post(
        '/categories',
        data: {
          'name': name,
        },
        options: _options(),
      );
      return ApiResponse.fromJson(
        response.data,
        (json) => ProductCategory.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ProductCategory?>> editCategory(int? id, String name) async {
    try {
      final response = await dio.put(
        '/categories/$id',
        data: {
          'name': name,
        },
        options: _options(),
      );
      return ApiResponse.fromJson(
        response.data,
            (json) => ProductCategory.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<String?>> deleteCategory(int? id) async {
    try {
      final response = await dio.delete(
        '/categories/$id',
        options: _options(),
      );
      return ApiResponse.fromJson(
        response.data,
            (json) => json as String?,
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

  @override
  Future<LoginResult> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/login',
        data: {
          'username': username,
          'password': password,
        },
      );
      return LoginResult.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ApiException(message: e.response?.data['message']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<dynamic>> logout() async {
    try {
      final response = await dio.post(
        '/logout',
        options: _options(),
      );
      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => null,
      );
    } catch (e) {
      rethrow;
    }
  }
}
