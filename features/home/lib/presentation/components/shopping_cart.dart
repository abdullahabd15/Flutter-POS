import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/components/empty_cart.dart';
import 'package:home/presentation/components/item_shopping_cart.dart';
import 'package:home/presentation/cubit/cart/cart_cubit.dart';
import 'package:home/presentation/cubit/cart/cart_state.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.initialLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.isCartEmpty) {
          return const EmptyCart();
        }
        final itemsCart = state.items ?? [];
        return itemsCart.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  final itemCart = itemsCart[index];
                  return SizedBox(
                    height: 96,
                    child: ItemShoppingCart(
                      data: itemCart,
                      onQtyChanged: (qty) {
                        cartCubit.addItemCart(itemCart.productId, qty);
                      },
                      onDeleteItemCart: (productId) {
                        cartCubit.deleteItemCart(productId);
                      },
                    ),
                  );
                },
                itemCount: itemsCart.length,
              )
            : Container();
      },
    );
  }
}
