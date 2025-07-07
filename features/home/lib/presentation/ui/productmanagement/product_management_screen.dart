import 'package:common/enums/input_mode.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/components/add_category_dialog.dart';
import 'package:home/presentation/cubit/category/category_cubit.dart';
import 'package:home/presentation/cubit/category/category_state.dart';

class ProductManagementScreen extends StatelessWidget {
  final TextEditingController _categoryController = TextEditingController();

  ProductManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryCubit(
        fetchProductCategoriesUseCase: sl(),
        addCategoryUseCase: sl(),
        editCategoryUseCase: sl(),
        deleteCategoryUseCase: sl(),
      )..fetchProductsCategories(),
      child: BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F8FB),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products or category...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _TabButton(
                      text: 'Products',
                      selected: false,
                      onTap: () {},
                    ),
                    const SizedBox(width: 8),
                    _TabButton(
                      text: 'Categories',
                      selected: true,
                      onTap: () {},
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
                        _showDialogCategory(
                          context,
                          onConfirm: (value) {
                            context.read<CategoryCubit>().addCategory(value);
                          },
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Category'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                    itemCount: state.categories.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 20),
                          child: Row(
                            children: [
                              // Category name and product count
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      category.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${category.itemCount ?? 0} products',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Action buttons
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  _showDialogCategory(
                                    context,
                                    mode: InputMode.edit,
                                    value: category.name,
                                    onConfirm: (value) {
                                      context
                                          .read<CategoryCubit>()
                                          .editCategory(category.id, value);
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _showDialogDeleteCategory(context, onConfirm: () {
                                    context.read<CategoryCubit>().deleteCategory(category.id);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _showDialogDeleteCategory(
    BuildContext context, {
    required Function onConfirm,
  }) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Delete Category'),
      content: const Text('Are you sure you want to delete this category?'),
      actions: [
        TextButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            GoRouter.of(context).pop();
          },
          child: const Text('Delete'),
        ),
      ],
    ));
  }

  void _showDialogCategory(
    BuildContext context, {
    required Function(String) onConfirm,
    InputMode mode = InputMode.add,
    String? value,
  }) {
    if (mode == InputMode.edit) {
      _categoryController.text = value ?? '';
    } else {
      _categoryController.clear();
    }
    showDialog(
      context: context,
      builder: (context) => AddCategoryDialog(
        controller: _categoryController,
        onCancel: () {
          GoRouter.of(context).pop();
        },
        onAdd: () {
          onConfirm(_categoryController.text);
          GoRouter.of(context).pop();
        },
        inputMode: mode,
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Colors.blue[700] : Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
