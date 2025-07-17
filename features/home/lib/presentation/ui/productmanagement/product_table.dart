import 'package:common/enums/input_mode.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/components/product_form_dialog.dart';
import 'package:home/presentation/cubit/category/category_cubit.dart';
import 'package:home/presentation/cubit/products/products_cubit.dart';
import 'package:home/presentation/cubit/products/products_state.dart';
import 'package:pos/data/models/product.dart';
import 'package:pos/data/models/product_body.dart';

class ProductTable extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  ProductTable({super.key});

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

  void _showProductDialog(
    BuildContext context, {
    required Function(ProductBody) onSave,
    InputMode mode = InputMode.add,
    Product? product,
  }) {
    if (mode == InputMode.edit) {
      _nameController.text = product?.name ?? '';
      _priceController.text = product?.price?.toString() ?? '';
      _stockController.text = product?.stock?.toString() ?? '';
    } else {
      _nameController.clear();
      _priceController.clear();
      _stockController.clear();
    }
    showDialog(
      context: context,
      builder: (context) => ProductFormDialog(
        nameController: _nameController,
        priceController: _priceController,
        stockController: _stockController,
        imageUrl: product?.imageName,
        category: product?.category,
        mode: mode,
        onCancel: () {
          GoRouter.of(context).pop();
        },
        onSave: (product) {
          onSave(product);
          GoRouter.of(context).pop();
        },
      ),
    );
  }

  void _showDeleteProductDialog(
    BuildContext context, {
    required Function onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              GoRouter.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            onPressed: () {
              onConfirm();
              GoRouter.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CategoryCubit(
            fetchProductCategoriesUseCase: sl(),
            deleteCategoryUseCase: sl(),
          )..fetchProductsCategories(),
        ),
        BlocProvider(
          create: (_) => ProductCubit(
            fetchProductUseCase: sl(),
            addProductUseCase: sl(),
            editProductUseCase: sl(),
            deleteProductUseCase: sl(),
          )..fetchProducts(),
        ),
      ],
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _showProductDialog(
                        context,
                        onSave: (product) {
                          context.read<ProductCubit>().addProduct(product);
                        },
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Add Product',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: DataTable(
                    headingRowColor:
                        MaterialStateProperty.all(const Color(0xFFF6F8FB)),
                    columns: const [
                      DataColumn(
                          label: Text('PRODUCT',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('CATEGORY',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('PRICE',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('STOCK',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('ACTIONS',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: state.products.map((product) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              product.name ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(Text(product.category ?? '')),
                          DataCell(
                              Text(_formatPrice(product.price?.toInt() ?? 0))),
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
                                  color: _stockTextColor(product.stock ?? 0),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          DataCell(Row(
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  _showProductDialog(
                                    context,
                                    mode: InputMode.edit,
                                    product: product,
                                    onSave: (value) {
                                      context
                                          .read<ProductCubit>()
                                          .editProduct(product.id, value);
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _showDeleteProductDialog(
                                    context,
                                    onConfirm: () {
                                      context
                                          .read<ProductCubit>()
                                          .deleteProduct(product.id);
                                    },
                                  );
                                },
                              ),
                            ],
                          )),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
