import 'package:common/error/failure_response.dart';
import 'package:core/network/api_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/login_result.dart';

abstract class AuthRepository {
  Future<Either<FailureResponse, LoginResult>> login(
    String username,
    String password,
  );

  Future<Either<FailureResponse, ApiResponse<dynamic>>> logout();
}
