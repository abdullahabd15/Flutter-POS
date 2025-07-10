import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pos/data/models/product_category.dart';

class ProductFormState {
  final List<ProductCategory> categories;
  final File? image;
  final Uint8List? imageBytes;
  final String? imageName;
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
    this.image,
    this.imageBytes,
    this.imageName,
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
    File? image,
    Uint8List? imageBytes,
    String? imageName,
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
      image: image ?? this.image,
      imageBytes: imageBytes ?? this.imageBytes,
      imageName: imageName ?? this.imageName,
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
