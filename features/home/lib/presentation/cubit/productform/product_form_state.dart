import 'package:pos/data/models/product_category.dart';

class ProductFormState {
  final List<ProductCategory> categories;
  final String name;
  final String? nameError;
  final String price;
  final String? priceError;
  final String stock;
  final String? stockError;
  final String category;
  final String? categoryError;

  ProductFormState({
    this.categories = const [],
    this.name = '',
    this.nameError,
    this.price = '',
    this.priceError,
    this.stock = '',
    this.stockError,
    this.category = '',
    this.categoryError,
  });

  ProductFormState copyWith({
    List<ProductCategory>? categories,
    String? name,
    String? nameError,
    String? price,
    String? priceError,
    String? stock,
    String? stockError,
    String? category,
    String? categoryError,
  }) {
    return ProductFormState(
      categories: categories ?? this.categories,
      name: name ?? this.name,
      nameError: nameError,
      price: price ?? this.price,
      priceError: priceError,
      stock: stock ?? this.stock,
      stockError: stockError,
      category: category ?? this.category,
      categoryError: categoryError ?? this.categoryError,
    );
  }
}
