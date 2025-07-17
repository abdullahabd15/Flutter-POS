import 'package:common/enums/input_mode.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/ui/productmanagement/category_form_cubit.dart';
import 'package:home/presentation/ui/productmanagement/category_form_state.dart';

class AddCategoryDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onCancel;
  final VoidCallback onSaveSuccess;
  final String? errorText;
  final InputMode inputMode;
  final int? categoryId;

  const AddCategoryDialog({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSaveSuccess,
    this.errorText,
    this.categoryId,
    this.inputMode = InputMode.add,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryFormCubit(
        addCategoryUseCase: sl(),
        editCategoryUseCase: sl(),
      ),
      child: BlocListener<CategoryFormCubit, CategoryFormState>(
        listener: (context, state) {
          if (state.categoryResult != null) {
            onSaveSuccess();
          }
        },
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
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
                          inputMode == InputMode.add
                              ? 'Add Category'
                              : 'Edit Category',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: onCancel,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Category Name',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      errorText: errorText,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: const Color(0xFFF6F8FB),
                            foregroundColor: Colors.black87,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: onCancel,
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      BlocBuilder<CategoryFormCubit, CategoryFormState>(
                          builder: (context, state) {
                        return Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[700],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () {
                              final cubit = context.read<CategoryFormCubit>();
                              if (inputMode == InputMode.add) {
                                cubit.addCategory(controller.text);
                              } else {
                                cubit.editCategory(categoryId, controller.text);
                              }
                            },
                            child: state.isLoading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    inputMode == InputMode.edit
                                        ? 'Save'
                                        : 'Add Category',
                                  ),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
