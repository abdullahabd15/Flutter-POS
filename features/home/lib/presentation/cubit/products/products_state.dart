import 'package:dependencies/equatable/equatable.dart';
import 'package:pos/data/models/product.dart';
import 'package:pos/data/models/product_category.dart';

class ProductState extends Equatable {
  final List<Product> allProducts;
  final List<Product> products;
  final String? errorMessage;

  const ProductState({
    required this.allProducts,
    required this.products,
    this.errorMessage,
  });

  ProductState copyWith({
    List<Product>? allProducts,
    List<Product>? products,
    String? errorMessage,
  }) {
    return ProductState(
      allProducts: allProducts ?? this.allProducts,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        products,
        errorMessage,
        allProducts,
      ];
}
