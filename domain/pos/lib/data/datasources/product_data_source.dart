import 'package:common/extension/extension.dart';
import 'package:core/network/api_response.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:pos/data/models/product.dart';
import 'package:pos/data/models/product_body.dart';

abstract class ProductDataSource {
  Future<ApiResponse<List<Product>>> fetchProducts();

  Future<ApiResponse<Product?>> addProduct(ProductBody product);

  Future<ApiResponse<Product?>> editProduct(int? id, ProductBody product);

  Future<ApiResponse<String?>> deleteProduct(int? id);
}

class ProductDataSourceImpl extends ProductDataSource {
  final Dio dio;
  final SharedPreferences prefs;

  ProductDataSourceImpl({required this.dio, required this.prefs});

  Options _options() {
    return Options(
      headers: {
        'Authorization': 'Bearer ${prefs.getToken()}',
      },
    );
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
  Future<ApiResponse<Product?>> addProduct(ProductBody product) async {
    try {
      final formData = FormData.fromMap({
        'name': product.name,
        'category': product.category,
        'price': product.price,
        'stock': product.stock,
        if (product.image != null)
          'image': MultipartFile.fromBytes(
            product.image!,
            filename: product.imageName,
            contentType: DioMediaType('image', 'png'),
          ),
      });
      final customDio = dio..interceptors.clear();
      final response = await customDio.post(
        '/products',
        data: formData,
        options: _options()..contentType = 'multipart/form-data',
      );
      return ApiResponse.fromJson(
        response.data,
        (json) => Product.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<String?>> deleteProduct(int? id) async {
    try {
      final response = await dio.delete(
        '/products/$id',
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
  Future<ApiResponse<Product?>> editProduct(
    int? id,
    ProductBody product,
  ) async {
    try {
      final formData = FormData.fromMap({
        '_method': 'PUT',
        'name': product.name,
        'category': product.category,
        'price': product.price,
        'stock': product.stock,
        if (product.image != null)
          'image': MultipartFile.fromBytes(
            product.image!,
            filename: product.imageName,
            contentType: DioMediaType('image', 'png'),
          ),
      });
      final customDio = dio..interceptors.clear();
      final response = await customDio.post(
        '/products/$id',
        data: formData,
        options: _options()..contentType = 'multipart/form-data',
      );
      return ApiResponse.fromJson(
        response.data,
        (json) => Product.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }
}
