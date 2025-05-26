import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/components/product_category_list.dart';
import 'package:home/presentation/components/product_grid_view.dart';
import 'package:home/presentation/cubit/cart/cart_cubit.dart';
import 'package:home/presentation/cubit/products/products_state.dart';
import 'package:home/presentation/cubit/products/products_cubit.dart';
import 'package:pos/data/models/product.dart';
import 'package:pos/data/models/product_category.dart';

class HomeLeftSide extends StatelessWidget {
  const HomeLeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductCubit>();
    final cartCubit = context.read<CartCubit>();
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          BlocSelector<ProductCubit, ProductState, List<ProductCategory>>(
            selector: (state) => state.categories,
            builder: (context, categories) => SizedBox(
              height: 38,
              child: categories.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ProductCategoryList(
                        data: categories,
                        onCategorySelected: (categoryName) {
                          productCubit.setSelectedCategory(categoryName);
                        },
                      ),
                    )
                  : Container(),
            ),
          ),
          const SizedBox(height: 8),
          BlocSelector<ProductCubit, ProductState, List<Product>>(
            selector: (state) => state.products,
            builder: (context, products) {
              return Expanded(
                child: products.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ProductGridView(
                          data: products,
                          onProductClicked: (productId) {
                            cartCubit.addItemCart(productId, 1);
                          },
                        ),
                      )
                    : Container(),
              );
            },
          ),
        ],
      ),
    );
  }
}
