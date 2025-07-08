import 'package:common/error/api_exception.dart';
import 'package:common/error/failure_response.dart';
import 'package:core/network/api_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/datasources/auth_data_source.dart';
import 'package:pos/data/models/login_result.dart';
import 'package:pos/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<FailureResponse, LoginResult>> login(
      String username, String password) async {
    try {
      final result = await authDataSource.login(username, password);
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
  Future<Either<FailureResponse, ApiResponse<dynamic>>> logout() async {
    try {
      final result = await authDataSource.logout();
      if (result.success == true) {
        return Right(result);
      } else {
        return const Left(FailureResponse(message: 'Something went wrong'));
      }
    } catch (e) {
      return Left(FailureResponse(message: e.toString()));
    }
  }
}
