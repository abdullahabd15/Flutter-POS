import 'package:dependencies/get_it/get_it.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:pos/data/datasources/pos_data_source.dart';
import 'package:pos/data/repository_impl/pos_repository_impl.dart';
import 'package:pos/domain/repositories/pos_repository.dart';
import 'package:pos/domain/usecase/add_category_use_case.dart';
import 'package:pos/domain/usecase/add_item_cart_use_case.dart';
import 'package:pos/domain/usecase/checkout_use_case.dart';
import 'package:pos/domain/usecase/clear_items_cart_use_case.dart';
import 'package:pos/domain/usecase/delete_category_use_case.dart';
import 'package:pos/domain/usecase/delete_item_cart_use_case.dart';
import 'package:pos/domain/usecase/edit_category_use_case.dart';
import 'package:pos/domain/usecase/fetch_product_categories_use_case.dart';
import 'package:pos/domain/usecase/fetch_products_use_case.dart';
import 'package:pos/domain/usecase/fetch_shopping_cart_use_case.dart';
import 'package:pos/domain/usecase/fetch_transaction_history_use_case.dart';
import 'package:pos/domain/usecase/login_use_case.dart';
import 'package:pos/domain/usecase/logout_use_case.dart';

class PosModule {
  PosModule() {
    _registerPosModule();
  }

  void _registerPosModule() async {
    final prefs = await SharedPreferences.getInstance();

    sl.registerLazySingleton<PosDataSource>(
        () => PosDataSourceImpl(prefs: prefs, dio: sl()));

    sl.registerLazySingleton<PosRepository>(
        () => PosRepositoryImpl(posDataSource: sl()));

    sl.registerLazySingleton(() => AddItemCartUseCase(repository: sl()));
    sl.registerLazySingleton(() => ClearItemsCartUseCase(repository: sl()));
    sl.registerLazySingleton(() => DeleteItemCartUseCase(repository: sl()));
    sl.registerLazySingleton(
        () => FetchProductCategoriesUseCase(repository: sl()));
    sl.registerLazySingleton(() => FetchProductsUseCase(repository: sl()));
    sl.registerLazySingleton(() => FetchShoppingCartUseCase(repository: sl()));
    sl.registerLazySingleton(() => CheckoutUseCase(repository: sl()));
    sl.registerLazySingleton(
        () => FetchTransactionHistoryUseCase(repository: sl()));
    sl.registerLazySingleton(() => AddCategoryUseCase(repository: sl()));
    sl.registerLazySingleton(() => EditCategoryUseCase(repository: sl()));
    sl.registerLazySingleton(() => DeleteCategoryUseCase(repository: sl()));
    sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
    sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  }
}
