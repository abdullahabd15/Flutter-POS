import 'package:common/enums/input_mode.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home/presentation/cubit/productform/product_form_cubit.dart';
import 'package:home/presentation/cubit/productform/product_form_state.dart';
import 'package:pos/data/models/product_body.dart';
import 'package:pos/data/models/product_category.dart';
import 'package:core/network/api_constant.dart';

class ProductFormDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController stockController;
  final String? imageUrl;
  final String? category;
  final VoidCallback onCancel;
  final Function(ProductBody) onSave;
  final InputMode mode;

  const ProductFormDialog({
    super.key,
    required this.nameController,
    required this.priceController,
    required this.stockController,
    required this.imageUrl,
    required this.category,
    required this.onCancel,
    required this.onSave,
    this.mode = InputMode.add,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductFormCubit(
        fetchProductCategoriesUseCase: sl(),
      )
        ..fetchCategories()
        ..setName(nameController.text)
        ..setPrice(priceController.text)
        ..setStock(stockController.text)
        ..setCategory(category),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: BlocBuilder<ProductFormCubit, ProductFormState>(
            builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          mode == InputMode.add
                              ? 'Add Product'
                              : 'Edit Product',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: onCancel,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        context.read<ProductFormCubit>().pickImage();
                      },
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: state.image != null || imageUrl != null
                            ? Colors.transparent
                            : Colors.grey[200],
                        backgroundImage: imageUrl != null && state.image == null
                            ? NetworkImage(
                                '${ApiConstant.baseUrlImage}$imageUrl',
                              )
                            : state.image != null && state.imageBytes != null
                                ? kIsWeb
                                    ? MemoryImage(state.imageBytes!)
                                    : FileImage(state.image!)
                                : null,
                        child: state.image == null && imageUrl == null
                            ? const Icon(Icons.image,
                                size: 40, color: Colors.grey)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Product Name',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) =>
                        context.read<ProductFormCubit>().setName(value),
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      errorText: state.nameError,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Category Dropdown
                  const Text('Category',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<ProductCategory?>(
                    value: state.categories
                            .where((e) => e.name == state.category)
                            .isNotEmpty
                        ? state.categories
                            .firstWhere((e) => e.name == state.category)
                        : null,
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('Select Category'),
                      ),
                      ...state.categories.map(
                        (category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category.name ?? ''),
                          );
                        },
                      )
                    ],
                    onChanged: (value) {
                      context.read<ProductFormCubit>().setCategory(value?.name);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      errorText: state.categoryError,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                    ),
                    hint: const Text('Select Category'),
                  ),
                  const SizedBox(height: 16),
                  // Price
                  const Text('Price',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) =>
                        context.read<ProductFormCubit>().setPrice(value),
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      errorText: state.priceError,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Stock
                  const Text('Stock',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) =>
                        context.read<ProductFormCubit>().setStock(value),
                    controller: stockController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      errorText: state.stockError,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: const Color(0xFFF6F8FB),
                            foregroundColor: Colors.black87,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: onCancel,
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            if (context.read<ProductFormCubit>().validate()) {
                              final product = ProductBody(
                                name: state.name,
                                category: state.category,
                                price: double.parse(state.price),
                                stock: int.parse(state.stock),
                                image: state.imageBytes,
                                imageName: state.imageName,
                              );
                              onSave(product);
                            }
                          },
                          child: Text(
                              mode == InputMode.add ? 'Add Product' : 'Save'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
