import 'package:dependencies/bloc/bloc.dart';
import 'package:home/presentation/cubit/transactions/transactions_state.dart';
import 'package:pos/data/models/checkout_body.dart';
import 'package:pos/domain/usecase/checkout_use_case.dart';

class TransactionCubit extends Cubit<TransactionsState> {
  final CheckoutUseCase checkoutUseCase;

  TransactionCubit({
    required this.checkoutUseCase,
  }) : super(
          const TransactionsState(
            transaction: null,
          ),
        );

  Future<void> checkout(CheckoutBody? body) async {
    if (body == null) return;
    final result = await checkoutUseCase.execute(body);
    result.fold(
      (failure) => emit(state),
      (data) => emit(state.copyWith(transaction: data)),
    );
  }
}
