import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/cubit/cart/cart_cubit.dart';
import 'package:home/presentation/cubit/products/products_cubit.dart';
import 'package:home/presentation/cubit/transactions/transactions_cubit.dart';
import 'package:home/presentation/ui/home/home_left_side.dart';
import 'package:home/presentation/ui/home/home_right_side.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductCubit(
            fetchProductUseCase: sl(),
            fetchProductCategoriesUseCase: sl(),
          )
            ..fetchProductsCategories()
            ..fetchProducts(),
        ),
        BlocProvider(
          create: (_) => CartCubit(
            fetchShoppingCartUseCase: sl(),
            addItemCartUseCase: sl(),
            deleteItemCartUseCase: sl(),
            clearItemsCartUseCase: sl(),
          )..fetchShoppingCart(),
        ),
        BlocProvider(
          create: (_) => TransactionCubit(
            checkoutUseCase: sl(),
          ),
        ),
      ],
      child: Row(
        children: [
          SizedBox(
            width: screenWidth * 0.65,
            height: double.infinity,
            child: const HomeLeftSide(),
          ),
          SizedBox(
            width: screenWidth * 0.35,
            height: double.infinity,
            child: const HomeRightSide(),
          ),
        ],
      ),
    );
  }
}
