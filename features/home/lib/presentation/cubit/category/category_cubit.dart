import 'package:dependencies/bloc/bloc.dart';
import 'package:home/presentation/cubit/category/category_state.dart';
import 'package:pos/domain/usecase/delete_category_use_case.dart';
import 'package:pos/domain/usecase/fetch_product_categories_use_case.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FetchProductCategoriesUseCase fetchProductCategoriesUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  CategoryCubit({
    required this.fetchProductCategoriesUseCase,
    required this.deleteCategoryUseCase,
  }) : super(
          const CategoryState(
            categories: [],
          ),
        );

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
