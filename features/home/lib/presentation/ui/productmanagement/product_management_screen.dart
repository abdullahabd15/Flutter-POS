import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/cubit/products/products_cubit.dart';
import 'package:home/presentation/cubit/products/products_state.dart';

class ProductManagementScreen extends StatelessWidget {
  const ProductManagementScreen({super.key});

  Color _stockColor(int stock) {
    if (stock <= 5) return Colors.red[200]!;
    if (stock <= 10) return Colors.yellow[200]!;
    return Colors.green[100]!;
  }

  Color _stockTextColor(int stock) {
    if (stock <= 5) return Colors.red[800]!;
    if (stock <= 10) return Colors.orange[800]!;
    return Colors.green[800]!;
  }

  String _formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit(
        fetchProductCategoriesUseCase: sl(),
        fetchProductUseCase: sl(),
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFFF6F8FB),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 80,
            title: Row(
              children: [
                TabBar(
                  indicator: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black87,
                  tabs: const [
                    Tab(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text('Products',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                    Tab(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text('Categories',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                  ],
                ),
                const Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // TODO: Add product action
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Product'),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: TabBarView(
              children: [
                // Products Tab
                BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: DataTable(
                        columnSpacing: 24,
                        headingRowColor:
                            MaterialStateProperty.all(const Color(0xFFF6F8FB)),
                        columns: const [
                          DataColumn(
                              label: Text('PRODUCT',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('CATEGORY',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('PRICE',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('STOCK',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('ACTIONS',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: state.products.map((product) {
                          return DataRow(
                            cells: [
                              DataCell(Row(
                                children: [
                                  // Text(product.imagePath ?? '',
                                  //     style: const TextStyle(fontSize: 24)),
                                  // const SizedBox(width: 8),
                                  Text(product.name ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                              DataCell(Text(product.category ?? '')),
                              DataCell(Text(
                                  _formatPrice(product.price?.toInt() ?? 0))),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _stockColor(product.stock ?? 0),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    '${product.stock} pcs',
                                    style: TextStyle(
                                      color:
                                          _stockTextColor(product.stock ?? 0),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    onPressed: () {
                                      // TODO: Edit product
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      // TODO: Delete product
                                    },
                                  ),
                                ],
                              )),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                // Categories Tab (dummy)
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                    child: Text('Categories management coming soon!'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
