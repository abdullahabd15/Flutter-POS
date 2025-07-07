import 'package:dependencies/bloc/bloc.dart';
import 'package:home/presentation/cubit/products/products_state.dart';
import 'package:pos/domain/usecase/fetch_products_use_case.dart';

class ProductCubit extends Cubit<ProductState> {
  final FetchProductsUseCase fetchProductUseCase;

  ProductCubit({
    required this.fetchProductUseCase,
  }) : super(
          const ProductState(
            allProducts: [],
            products: [],
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

  void onCategorySelected(String? categoryName) {
    final products = categoryName == 'All'
        ? state.allProducts
        : state.allProducts.where((e) => e.category == categoryName).toList();
    emit(
      state.copyWith(
        products: products,
      ),
    );
  }
}
