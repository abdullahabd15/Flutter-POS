import 'package:common/extension/extension.dart';
import 'package:core/network/api_response.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:pos/data/models/product_category.dart';

abstract class CategoryDataSource {
  Future<ApiResponse<List<ProductCategory>>> fetchProductCategories();

  Future<ApiResponse<ProductCategory?>> addCategory(String name);

  Future<ApiResponse<ProductCategory?>> editCategory(int? id, String name);

  Future<ApiResponse<String?>> deleteCategory(int? id);
}

class CategoryDataSourceImpl extends CategoryDataSource {
  final Dio dio;
  final SharedPreferences prefs;

  CategoryDataSourceImpl({required this.dio, required this.prefs});

  Options _options() {
    return Options(
      headers: {
        'Authorization': 'Bearer ${prefs.getToken()}',
      },
    );
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
  Future<ApiResponse<ProductCategory?>> editCategory(
      int? id, String name) async {
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
}
