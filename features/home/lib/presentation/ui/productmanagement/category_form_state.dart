import 'package:common/enums/input_mode.dart';
import 'package:pos/data/models/product_category.dart';

class CategoryFormState {
  final bool isLoading;
  final String? errorMessage;
  final InputMode mode;
  final ProductCategory? categoryResult;

  CategoryFormState({
    this.isLoading = false,
    this.mode = InputMode.add,
    this.categoryResult,
    this.errorMessage,
  });

  CategoryFormState copyWith({
    bool? isLoading,
    String? errorMessage,
    InputMode? mode,
    ProductCategory? categoryResult,
  }) {
    return CategoryFormState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      mode: mode ?? this.mode,
      categoryResult: categoryResult ?? this.categoryResult,
    );
  }
}
