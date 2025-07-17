import 'package:dependencies/bloc/bloc.dart';
import 'package:home/presentation/ui/productmanagement/category_form_state.dart';
import 'package:pos/domain/usecase/add_category_use_case.dart';
import 'package:pos/domain/usecase/edit_category_use_case.dart';

class CategoryFormCubit extends Cubit<CategoryFormState> {
  final AddCategoryUseCase addCategoryUseCase;
  final EditCategoryUseCase editCategoryUseCase;

  CategoryFormCubit({
    required this.addCategoryUseCase,
    required this.editCategoryUseCase,
  }) : super(CategoryFormState());

  Future<void> addCategory(String name) async {
    emit(state.copyWith(isLoading: true));
    final result = await addCategoryUseCase.execute(name);
    result.fold(
      (failure) =>
          emit(state.copyWith(errorMessage: failure.message, isLoading: false)),
      (data) => emit(state.copyWith(categoryResult: data, isLoading: false)),
    );
  }

  Future<void> editCategory(int? id, String name) async {
    emit(state.copyWith(isLoading: true));
    final result = await editCategoryUseCase.execute(id, name);
    result.fold(
      (failure) =>
          emit(state.copyWith(errorMessage: failure.message, isLoading: false)),
      (data) => emit(state.copyWith(categoryResult: data, isLoading: false)),
    );
  }
}
