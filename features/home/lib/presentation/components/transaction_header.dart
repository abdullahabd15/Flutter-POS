import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/cubit/cart/cart_cubit.dart';
import 'package:home/presentation/cubit/cart/cart_state.dart';

class TransactionHeader extends StatelessWidget {
  const TransactionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocSelector<CartCubit, CartState, String?>(
            selector: (state) => state.orderId,
            builder: (context, orderId) => Text(orderId ?? ''),
          ),
          const SizedBox(width: 8),
          BlocSelector<CartCubit, CartState, bool>(
            selector: (state) => state.isCartEmpty,
            builder: (context, isCartEmpty) => !isCartEmpty
                ? OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.redAccent),
                    ),
                    onPressed: () {
                      cartCubit.clearItemsCart();
                    },
                    child: const Row(
                      children: [
                        Iconify(
                          Ph.trash_light,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Clear',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
