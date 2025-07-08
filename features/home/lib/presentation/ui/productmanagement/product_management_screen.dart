import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/cubit/productmanagement/product_management_cubit.dart';
import 'package:home/presentation/cubit/productmanagement/product_management_state.dart';
import 'package:home/presentation/ui/productmanagement/product_categories.dart';
import 'package:home/presentation/ui/productmanagement/product_table.dart';

class ProductManagementScreen extends StatelessWidget {
  const ProductManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductManagementCubit(),
      child: BlocBuilder<ProductManagementCubit, ProductManagementState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF6F8FB),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products or category...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _TabButton(
                        text: 'Products',
                        selected:
                            state.selectedTab == ProductManagementTab.products,
                        onTap: () {
                          context
                              .read<ProductManagementCubit>()
                              .onTabSelected(ProductManagementTab.products);
                        },
                      ),
                      const SizedBox(width: 8),
                      _TabButton(
                        text: 'Categories',
                        selected: state.selectedTab ==
                            ProductManagementTab.categories,
                        onTap: () {
                          context
                              .read<ProductManagementCubit>()
                              .onTabSelected(ProductManagementTab.categories);
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: state.selectedTab == ProductManagementTab.products
                        ? ProductTable()
                        : ProductCategories(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Colors.blue[700] : Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
