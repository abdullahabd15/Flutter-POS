import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/domain/repositories/pos_repository.dart';

import '../../data/models/login_result.dart';

class LoginUseCase {
  final PosRepository repository;

  const LoginUseCase({required this.repository});

  Future<Either<FailureResponse, LoginResult>> execute(
    String username,
    String password,
  ) => repository.login(username, password);
}
