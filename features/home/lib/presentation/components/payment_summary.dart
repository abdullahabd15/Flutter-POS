import 'package:common/extension/extension.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/cubit/cart/cart_cubit.dart';
import 'package:home/presentation/cubit/cart/cart_state.dart';

class PaymentSummary extends StatelessWidget {
  final Function() onOrderClicked;

  const PaymentSummary({super.key, required this.onOrderClicked});

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(fontSize: 16);
    final boldTextStyle =
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Divider(thickness: 0.6),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryRow(
                  title: 'Subtotal',
                  valueSelector: (state) => state.subtotal,
                  style: textStyle,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      final taxPercentage = state.taxPercentage ?? 0;
                      final tax = state.tax ?? 0;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tax ($taxPercentage%)', style: textStyle),
                          Text(tax.convertToCurrency(), style: textStyle),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  title: 'Total',
                  valueSelector: (state) => state.total,
                  style: boldTextStyle,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: FilledButton(
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: onOrderClicked,
              child: const Text(
                'Order',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required String title,
    required double? Function(CartState state) valueSelector,
    required TextStyle style,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BlocSelector<CartCubit, CartState, double?>(
        selector: valueSelector,
        builder: (context, value) {
          final formattedValue = value.convertToCurrency();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: style),
              Text(formattedValue, style: style),
            ],
          );
        },
      ),
    );
  }
}
