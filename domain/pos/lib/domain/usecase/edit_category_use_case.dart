import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/product_category.dart';
import 'package:pos/domain/repositories/pos_repository.dart';

class EditCategoryUseCase {
  final PosRepository repository;

  EditCategoryUseCase({required this.repository});

  Future<Either<FailureResponse, ProductCategory?>> execute(int? id, String name) =>
      repository.editCategory(id, name);
}
