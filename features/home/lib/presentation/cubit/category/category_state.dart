import 'package:dependencies/equatable/equatable.dart';
import 'package:pos/data/models/product_category.dart';

class CategoryState extends Equatable {
  final List<ProductCategory> categories;
  final String? selectedCategory;
  final String? errorMessage;

  const CategoryState({
    required this.categories,
    this.selectedCategory,
    this.errorMessage,
  });

  CategoryState copyWith({
    List<ProductCategory>? categories,
    String? selectedCategory,
    String? errorMessage,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        errorMessage,
        selectedCategory,
      ];
}
