import 'package:common/extension/extension.dart';
import 'package:common/utils/date_utils_2.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/data_table_2/data_table_2.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:order/presentation/components/transaction_items_dialog.dart';
import 'package:order/presentation/components/transactions_table_filter.dart';
import 'package:order/presentation/cubit/date_range_picker_cubit.dart';
import 'package:order/presentation/cubit/transactions_cubit.dart';
import 'package:order/presentation/cubit/transactions_state.dart';
import 'package:pos/data/models/transaction.dart';
import 'package:resources/constants/constant.dart';

class TransactionsHistoryScreen extends StatelessWidget {
  const TransactionsHistoryScreen({super.key});

  void _showTransactionItems(BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (ctx) => TransactionItemsDialog(transaction: transaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TransactionsCubit(
            fetchTransactionHistoryUseCase: sl(),
          )..fetchTransactionsHistory(),
        ),
        BlocProvider(
          create: (_) => DateRangePickerCubit(),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<TransactionsCubit, TransactionsState>(
                builder: (context, state) {
              return PaginatedDataTable2(
                header: TransactionsTableFilter(
                  onSearchByDateRange: ({fromDate, toDate}) {
                    final transactionCubit = context.read<TransactionsCubit>();
                    transactionCubit.fetchTransactionsHistory(
                      fromDate: fromDate,
                      toDate: toDate,
                    );
                  },
                ),
                columnSpacing: 12,
                horizontalMargin: 12,
                headingTextStyle: const TextStyle(fontWeight: FontWeight.w700),
                rowsPerPage: 15,
                renderEmptyRowsInTheEnd: false,
                wrapInCard: false,
                columns: const [
                  DataColumn2(
                    label: Text('Id'),
                    headingRowAlignment: MainAxisAlignment.center,
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('Date'),
                    headingRowAlignment: MainAxisAlignment.center,
                  ),
                  DataColumn2(
                    label: Text('Time'),
                    headingRowAlignment: MainAxisAlignment.center,
                  ),
                  DataColumn2(
                    label: Text('Total'),
                    headingRowAlignment: MainAxisAlignment.center,
                  ),
                  DataColumn2(
                    label: Text('Tax'),
                    headingRowAlignment: MainAxisAlignment.center,
                  ),
                  DataColumn2(
                    label: Text('Status'),
                    headingRowAlignment: MainAxisAlignment.center,
                  ),
                  DataColumn2(
                    label: Text('Items'),
                    headingRowAlignment: MainAxisAlignment.center,
                  ),
                ],
                source: TransactionsDataSource(
                  state.transactionHistory,
                  onSeeItemsClick: (transaction) => _showTransactionItems(
                    context,
                    transaction,
                  ),
                ),
                empty: const Center(
                  child: Text('No data'),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class TransactionsDataSource extends DataTableSource {
  final Function(Transaction) onSeeItemsClick;
  final List<Transaction> _data;

  TransactionsDataSource(
    this._data, {
    required this.onSeeItemsClick,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) return null;
    final item = _data[index];
    final date = DateUtils2.changeDateFormat(
      item.dateTime,
      oldFormat: DateTimeConst.defaultDateTimeFormatFromAPI,
      newFormat: DateTimeConst.defaultDateFormat,
    );
    final time = DateUtils2.changeDateFormat(
      item.dateTime,
      oldFormat: DateTimeConst.defaultDateTimeFormatFromAPI,
      newFormat: DateTimeConst.defaultTimeFormat,
    );
    return DataRow(
      cells: [
        DataCell(Center(child: Text(item.id?.toString() ?? ''))),
        DataCell(Center(child: Text(date))),
        DataCell(Center(child: Text(time))),
        DataCell(Center(child: Text(item.totalPrice.convertToCurrency()))),
        DataCell(Center(child: Text(item.tax.convertToCurrency()))),
        DataCell(Center(child: Text(item.status ?? ''))),
        DataCell(
          Center(
            child: ElevatedButton(
              onPressed: () => onSeeItemsClick(_data[index]),
              child: const Text('See Items'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
