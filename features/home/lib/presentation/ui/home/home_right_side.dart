import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/components/payment_summary.dart';
import 'package:home/presentation/components/shopping_cart.dart';
import 'package:home/presentation/components/transaction_header.dart';
import 'package:home/presentation/cubit/cart/cart_cubit.dart';
import 'package:home/presentation/cubit/cart/cart_state.dart';
import 'package:home/presentation/cubit/transactions/transactions_cubit.dart';

class HomeRightSide extends StatelessWidget {
  const HomeRightSide({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final double headerHeight = 58;
    final transactionCubit = context.read<TransactionCubit>();
    final cartCubit = context.read<CartCubit>();
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: headerHeight,
            child: const TransactionHeader(),
          ),
          const SizedBox(height: 1),
          SizedBox(
            height: (height * 0.8) - headerHeight - headerHeight,
            child: const ShoppingCart(),
          ),
          SizedBox(
            height: (height * 0.2) - 1,
            child: BlocSelector<CartCubit, CartState, bool>(
              selector: (state) => state.isCartEmpty,
              builder: (context, isCartEmpty) => !isCartEmpty
                  ? PaymentSummary(
                      onOrderClicked: () => transactionCubit
                          .checkout(cartCubit.state.checkoutBody),
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
