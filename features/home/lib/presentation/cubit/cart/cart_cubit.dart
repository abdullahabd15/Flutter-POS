import 'package:dependencies/bloc/bloc.dart';
import 'package:home/presentation/cubit/cart/cart_state.dart';
import 'package:pos/domain/usecase/add_item_cart_use_case.dart';
import 'package:pos/domain/usecase/clear_items_cart_use_case.dart';
import 'package:pos/domain/usecase/delete_item_cart_use_case.dart';
import 'package:pos/domain/usecase/fetch_shopping_cart_use_case.dart';

class CartCubit extends Cubit<CartState> {
  final FetchShoppingCartUseCase fetchShoppingCartUseCase;
  final AddItemCartUseCase addItemCartUseCase;
  final DeleteItemCartUseCase deleteItemCartUseCase;
  final ClearItemsCartUseCase clearItemsCartUseCase;

  CartCubit({
    required this.fetchShoppingCartUseCase,
    required this.addItemCartUseCase,
    required this.deleteItemCartUseCase,
    required this.clearItemsCartUseCase,
  }) : super(const CartState());

  Future<void> fetchShoppingCart() async {
    final result = await fetchShoppingCartUseCase.execute();
    result.fold(
      (failure) => emit(state.copyWih(initialLoading: false)),
      (data) => emit(state.updateState(cart: data, initialLoading: false)),
    );
  }

  Future<void> addItemCart(int? productId, int qty) async {
    final result = await addItemCartUseCase.execute(productId, qty);
    result.fold(
      (failure) => emit(state),
      (data) => emit(state.copyWih(
        orderId: state.orderId ?? data.orderId,
        items: data.items,
        subtotal: data.subtotal,
        total: data.total,
        tax: data.tax,
      )),
    );
  }

  Future<void> deleteItemCart(int? productId) async {
    final result = await deleteItemCartUseCase.execute(productId);
    result.fold(
      (failure) => emit(state),
      (data) => emit(state.copyWih(
        items: data.items,
        subtotal: data.subtotal,
        total: data.total,
        tax: data.tax,
      )),
    );
  }

  Future<void> clearItemsCart() async {
    final result = await clearItemsCartUseCase.execute();
    result.fold(
      (failure) => emit(state),
      (data) => emit(state.copyWih(
        items: data.items,
        subtotal: data.subtotal,
        total: data.total,
        tax: data.tax,
      )),
    );
  }
}
