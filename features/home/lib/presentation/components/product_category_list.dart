import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/cubit/products/products_state.dart';
import 'package:home/presentation/cubit/products/products_cubit.dart';
import 'package:pos/data/models/product_category.dart';

class ProductCategoryList extends StatelessWidget {
  final List<ProductCategory> data;
  final Function(String?) onCategorySelected;

  const ProductCategoryList({
    super.key,
    required this.data,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final category = data[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(50),
            child: BlocSelector<ProductCubit, ProductState, String?>(
                selector: (state) => state.selectedCategory,
                builder: (context, selectedCategoryName) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      border: selectedCategoryName == category.name
                          ? Border.all(color: Colors.blueAccent, width: 1)
                          : null,
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(iconColor: Colors.black),
                      onPressed: () {
                        onCategorySelected(category.name);
                      },
                      child: Text(
                        category.name ?? '',
                        style: TextStyle(
                          color: selectedCategoryName == category.name
                              ? Colors.blueAccent
                              : Colors.black,
                          fontSize: 14,
                          fontWeight: selectedCategoryName == category.name
                              ? FontWeight.w700
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
