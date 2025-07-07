import 'package:common/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:pos/data/models/product_category.dart';
import 'package:pos/domain/repositories/pos_repository.dart';

class AddCategoryUseCase {
  final PosRepository repository;

  AddCategoryUseCase({required this.repository});

  Future<Either<FailureResponse, ProductCategory?>> execute(String name) =>
      repository.addCategory(name);
}
