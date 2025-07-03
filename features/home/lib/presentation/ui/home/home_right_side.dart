import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/cubit/cart/cart_cubit.dart';
import 'package:home/presentation/cubit/cart/cart_state.dart';

class HomeRightSide extends StatelessWidget {
  const HomeRightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final items = state.items ?? [];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Orders #',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        leading: Image.network(
                          item.imagePath ?? '',
                          width: 40,
                          height: 40,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.fastfood),
                        ),
                        title: Text(item.name ?? ''),
                        subtitle: Text('Rp. ${item.price}'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('x${item.qty}'),
                            Text(
                                'Rp. ${(item.price ?? 0) * (item.qty?.toDouble() ?? 0)}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Integrasi pembayaran cash
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white),
                      child: const Text('CASH'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Integrasi pembayaran QR
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white),
                      child: const Text('QR'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Integrasi pembayaran transfer
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white),
                      child: const Text('TRANSFER'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Rp. ${state.total ?? 0}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Integrasi checkout
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white),
                    child: const Text('Payment'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
