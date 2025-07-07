import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/cubit/cart/cart_cubit.dart';
import 'package:home/presentation/cubit/category/category_cubit.dart';
import 'package:home/presentation/cubit/category/category_state.dart';
import 'package:home/presentation/cubit/products/products_cubit.dart';
import 'package:home/presentation/cubit/products/products_state.dart';

class HomeLeftSide extends StatelessWidget {
  const HomeLeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 400,
                child: TextField(
                  onChanged: null,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                final categories = state.categories;
                return SizedBox(
                  height: 48,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length + 1,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return FilterChip(
                          label: const Text('All'),
                          selected: state.selectedCategory == null,
                          onSelected: (_) => context
                              .read<ProductCubit>()
                              .onCategorySelected(null),
                        );
                      }
                      final category = categories[index - 1];
                      return FilterChip(
                        label: Text(category.name ?? ''),
                        selected: state.selectedCategory == category.name,
                        onSelected: (_) => context
                            .read<ProductCubit>()
                            .onCategorySelected(category.name),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  final products = state.products;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 4 / 5,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Image.network(
                                  product.imagePath ?? '',
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.fastfood, size: 48),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.name ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('Rp. ${product.price}'),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<CartCubit>()
                                      .addItemCart(product.id, 1);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(8),
                                ),
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
