import 'package:common/error/failure_response.dart';
import 'package:core/network/api_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/domain/repositories/pos_repository.dart';

class LogoutUseCase {
  final PosRepository repository;

  const LogoutUseCase({required this.repository});

  Future<Either<FailureResponse, ApiResponse<dynamic>>> execute() =>
      repository.logout();
}
