import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/login_result.dart';
import 'package:pos/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  const LoginUseCase({required this.repository});

  Future<Either<FailureResponse, LoginResult>> execute(
    String username,
    String password,
  ) => repository.login(username, password);
}
