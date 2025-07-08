import 'package:common/error/api_exception.dart';
import 'package:common/extension/extension.dart';
import 'package:core/network/api_response.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:pos/data/models/login_result.dart';

abstract class AuthDataSource {
  Future<LoginResult> login(String username, String password);

  Future<ApiResponse<dynamic>> logout();
}

class AuthDataSourceImpl extends AuthDataSource {
  final Dio dio;
  final SharedPreferences prefs;

  AuthDataSourceImpl({required this.dio, required this.prefs});

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
        options: Options(
          headers: {
            'Authorization': 'Bearer ${prefs.getToken()}',
          },
        ),
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
