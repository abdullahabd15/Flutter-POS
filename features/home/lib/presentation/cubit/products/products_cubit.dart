import 'package:dependencies/bloc/bloc.dart';
import 'package:home/presentation/cubit/products/products_state.dart';
import 'package:pos/data/models/product_body.dart';
import 'package:pos/domain/usecase/add_product_use_case.dart';
import 'package:pos/domain/usecase/delete_product_use_case.dart';
import 'package:pos/domain/usecase/edit_product_use_case.dart';
import 'package:pos/domain/usecase/fetch_products_use_case.dart';

class ProductCubit extends Cubit<ProductState> {
  final FetchProductsUseCase fetchProductUseCase;
  final AddProductUseCase addProductUseCase;
  final EditProductUseCase editProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  ProductCubit({
    required this.fetchProductUseCase,
    required this.addProductUseCase,
    required this.editProductUseCase,
    required this.deleteProductUseCase,
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

  Future<void> addProduct(ProductBody product) async {
    final result = await addProductUseCase.execute(product);
    result.fold(
      (failure) => emit(state),
      (data) async {
        await fetchProducts();
      },
    );
  }

  Future<void> editProduct(int? productId, ProductBody product) async {
    final result = await editProductUseCase.execute(productId, product);
    result.fold(
      (failure) => emit(state),
      (data) async {
        await fetchProducts();
      },
    );
  }

  Future<void> deleteProduct(int? productId) async {
    final result = await deleteProductUseCase.execute(productId);
    result.fold(
      (failure) => emit(state),
      (data) async {
        await fetchProducts();
      },
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
