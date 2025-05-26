import 'package:dependencies/equatable/equatable.dart';
import 'package:pos/data/models/product.dart';
import 'package:pos/data/models/product_category.dart';

class ProductState extends Equatable {
  final List<Product> allProducts;
  final List<Product> products;
  final List<ProductCategory> categories;
  final String? selectedCategory;

  const ProductState({
    required this.allProducts,
    required this.products,
    required this.categories,
    this.selectedCategory,
  });

  ProductState copyWith({
    List<Product>? allProducts,
    List<Product>? products,
    List<ProductCategory>? categories,
    String? selectedCategory,
  }) {
    return ProductState(
      allProducts: allProducts ?? this.allProducts,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [products, categories];
}
