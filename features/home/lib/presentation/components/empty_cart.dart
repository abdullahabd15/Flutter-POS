import 'package:dependencies/iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Iconify(
            Ph.shopping_cart_light,
            size: 98,
          ),
          Text('Shopping cart is empty'),
        ],
      ),
    );
  }
}
