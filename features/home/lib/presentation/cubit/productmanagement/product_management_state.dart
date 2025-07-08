import 'package:dependencies/equatable/equatable.dart';

enum ProductManagementTab { products, categories }

class ProductManagementState extends Equatable {
  final ProductManagementTab selectedTab;

  const ProductManagementState({
    required this.selectedTab,
  });

  ProductManagementState copyWith({
    ProductManagementTab? selectedTab,
  }) {
    return ProductManagementState(
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object?> get props => [selectedTab];
}
