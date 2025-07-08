import 'package:dependencies/bloc/bloc.dart';
import 'package:home/presentation/cubit/category/category_state.dart';
import 'package:pos/domain/usecase/add_category_use_case.dart';
import 'package:pos/domain/usecase/delete_category_use_case.dart';
import 'package:pos/domain/usecase/edit_category_use_case.dart';
import 'package:pos/domain/usecase/fetch_product_categories_use_case.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FetchProductCategoriesUseCase fetchProductCategoriesUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final EditCategoryUseCase editCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  CategoryCubit({
    required this.fetchProductCategoriesUseCase,
    required this.addCategoryUseCase,
    required this.editCategoryUseCase,
    required this.deleteCategoryUseCase,
  }) : super(
          const CategoryState(
            categories: [],
          ),
        );

  Future<void> addCategory(String name) async {
    final result = await addCategoryUseCase.execute(name);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (data) async => await fetchProductsCategories(),
    );
  }

  Future<void> editCategory(int? id, String name) async {
    final result = await editCategoryUseCase.execute(id, name);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (data) async => await fetchProductsCategories(),
    );
  }

  Future<void> deleteCategory(int? id) async {
    final result = await deleteCategoryUseCase.execute(id);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (data) async => await fetchProductsCategories(),
    );
  }

  Future<void> fetchProductsCategories() async {
    final result = await fetchProductCategoriesUseCase.execute();
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (data) => emit(state.copyWith(categories: List.of(data))),
    );
  }

  void setSelectedCategory(String? categoryName) {
    emit(state.copyWith(selectedCategory: categoryName));
  }
}
