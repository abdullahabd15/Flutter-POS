import 'package:flutter/material.dart';
import 'package:pos/data/models/product.dart';

import 'item_product.dart';

class ProductGridView extends StatelessWidget {
  final List<Product> data;
  final Function(int? productId) onProductClicked;

  const ProductGridView({
    super.key,
    required this.data,
    required this.onProductClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 186,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3 / 3.8,
      ),
      itemBuilder: (context, index) {
        final item = data[index];
        return ItemProduct(data: item, onProductClicked: onProductClicked);
      },
    );
  }
}
