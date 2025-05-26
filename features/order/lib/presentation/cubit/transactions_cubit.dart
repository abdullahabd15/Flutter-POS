import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/intl/intl.dart';
import 'package:order/presentation/cubit/transactions_state.dart';
import 'package:pos/domain/usecase/fetch_transaction_history_use_case.dart';
import 'package:resources/constants/constant.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final FetchTransactionHistoryUseCase fetchTransactionHistoryUseCase;

  TransactionsCubit({
    required this.fetchTransactionHistoryUseCase,
  }) : super(const TransactionsState(transactionHistory: []));

  Future<void> fetchTransactionsHistory({
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final dateFormat = DateFormat(DateTimeConst.defaultDateFormatReversed);
    final result = await fetchTransactionHistoryUseCase.execute(
      fromDate: fromDate != null ? dateFormat.format(fromDate) : null,
      toDate: toDate != null ? dateFormat.format(toDate) : null,
    );
    result.fold(
      (failure) => emit(state),
      (data) => emit(
        state.copyWith(transactionHistory: data),
      ),
    );
  }
}
