import 'dart:io';

import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/image_picker/image_picker.dart';
import 'package:home/presentation/cubit/productform/product_form_state.dart';
import 'package:pos/domain/usecase/fetch_product_categories_use_case.dart';

class ProductFormCubit extends Cubit<ProductFormState> {
  final FetchProductCategoriesUseCase fetchProductCategoriesUseCase;

  ProductFormCubit({required this.fetchProductCategoriesUseCase})
      : super(ProductFormState());

  void setName(String value) =>
      emit(state.copyWith(name: value, nameError: null));

  void setPrice(String value) =>
      emit(state.copyWith(price: value, priceError: null));

  void setStock(String value) =>
      emit(state.copyWith(stock: value, stockError: null));

  void setCategory(String? value) =>
      emit(state.copyWith(category: value, categoryError: null));

  Future<void> fetchCategories() async {
    final result = await fetchProductCategoriesUseCase.execute();
    result.fold(
      (failure) => emit(state.copyWith(categoryError: failure.message)),
      (data) => emit(state.copyWith(categories: List.of(data))),
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageFile = File(image.path);
      final imageBytes = await XFile(image.path).readAsBytes();
      emit(state.copyWith(
        image: imageFile,
        imageBytes: imageBytes,
        imageName: image.name,
      ));
    }
  }

  bool validate() {
    emit(state.copyWith(
      nameError: state.name.isEmpty ? 'Product name is required' : null,
      priceError: state.price.isEmpty
          ? 'Price is required'
          : double.tryParse(state.price) == null
              ? 'Invalid price'
              : null,
      stockError: state.stock.isEmpty
          ? 'Stock is required'
          : int.tryParse(state.stock) == null
              ? 'Invalid stock'
              : null,
      categoryError: state.category.isEmpty ? 'Category is required' : null,
    ));
    return state.name.isNotEmpty &&
        state.price.isNotEmpty &&
        double.tryParse(state.price) != null &&
        state.stock.isNotEmpty &&
        int.tryParse(state.stock) != null &&
        state.category.isNotEmpty;
  }
}
