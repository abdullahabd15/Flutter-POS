import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/cubit/cart/cart_cubit.dart';
import 'package:home/presentation/cubit/category/category_cubit.dart';
import 'package:home/presentation/cubit/products/products_cubit.dart';
import 'package:home/presentation/ui/home/home_left_side.dart';
import 'package:home/presentation/ui/home/home_right_side.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        BlocProvider(
          create: (_) => CartCubit(
            fetchShoppingCartUseCase: sl(),
            addItemCartUseCase: sl(),
            deleteItemCartUseCase: sl(),
            clearItemsCartUseCase: sl(),
          ),
        ),
      ],
      child: const Scaffold(
        backgroundColor: Color(0xFFF6F8FB),
        body: Row(
          children: [
            HomeLeftSide(),
            HomeRightSide(),
          ],
        ),
      ),
    );
  }
}
