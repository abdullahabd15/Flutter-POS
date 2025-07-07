import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/domain/repositories/pos_repository.dart';

class DeleteCategoryUseCase {
  final PosRepository repository;

  DeleteCategoryUseCase({required this.repository});

  Future<Either<FailureResponse, String?>> execute(int? id) =>
      repository.deleteCategory(id);
}
