import 'package:common/extension/extension.dart';
import 'package:common/utils/date_utils_2.dart';
import 'package:dependencies/data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:pos/data/models/transaction.dart';
import 'package:resources/constants/constant.dart';

class TransactionItemsDialog extends StatelessWidget {
  final Transaction transaction;

  const TransactionItemsDialog({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final date = DateUtils2.changeDateFormat(
      transaction.dateTime,
      oldFormat: DateTimeConst.defaultDateTimeFormatFromAPI,
      newFormat: DateTimeConst.defaultDateFormat,
    );
    final time = DateUtils2.changeTimeFormat(transaction.dateTime);
    return AlertDialog(
      backgroundColor: Colors.white,
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Close"),
        ),
      ],
      content: SizedBox(
        width: size.width * 0.7,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: size.height * 0.4,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Transaction Date: $date $time',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Flexible(
                child: DataTable2(
                  headingTextStyle:
                      const TextStyle(fontWeight: FontWeight.w700),
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Qty')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Total')),
                  ],
                  rows: List.generate(
                    transaction.items?.length ?? 0,
                    (index) {
                      final item = transaction.items?[index];
                      return DataRow(
                        cells: [
                          DataCell(Text(item?.name ?? '')),
                          DataCell(Text(item?.qty?.toString() ?? '')),
                          DataCell(
                            Text(item?.price?.convertToCurrency() ?? ''),
                          ),
                          DataCell(
                            Text(item?.total?.convertToCurrency() ?? ''),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
