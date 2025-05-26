import 'package:dependencies/bloc/bloc.dart';
import 'package:home/presentation/cubit/products/products_state.dart';
import 'package:pos/domain/usecase/fetch_product_categories_use_case.dart';
import 'package:pos/domain/usecase/fetch_products_use_case.dart';

class ProductCubit extends Cubit<ProductState> {
  final FetchProductsUseCase fetchProductUseCase;
  final FetchProductCategoriesUseCase fetchProductCategoriesUseCase;

  ProductCubit({
    required this.fetchProductUseCase,
    required this.fetchProductCategoriesUseCase,
  }) : super(
          const ProductState(
            allProducts: [],
            products: [],
            categories: [],
            selectedCategory: 'All',
          ),
        );

  Future<void> fetchProducts() async {
    final result = await fetchProductUseCase.execute();
    result.fold(
      (failure) => emit(state),
      (data) => emit(state.copyWith(
        products: data,
        allProducts: data,
      )),
    );
  }

  Future<void> fetchProductsCategories() async {
    final result = await fetchProductCategoriesUseCase.execute();
    result.fold(
      (failure) => emit(state),
      (data) => emit(state.copyWith(categories: data)),
    );
  }

  void setSelectedCategory(String? categoryName) {
    final products = categoryName == 'All'
        ? state.allProducts
        : state.allProducts.where((e) => e.category == categoryName).toList();
    emit(state.copyWith(
      selectedCategory: categoryName,
      products: products,
    ));
  }
}
