import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:flutter/material.dart';
import 'package:order/presentation/cubit/date_range_picker_cubit.dart';
import 'package:order/presentation/cubit/date_range_picker_state.dart';

class TransactionsTableFilter extends StatelessWidget {
  final Function({DateTime? fromDate, DateTime? toDate}) onSearchByDateRange;

  const TransactionsTableFilter({
    super.key,
    required this.onSearchByDateRange,
  });

  void _showDatePicker(
      BuildContext context,
      Function(DateTime) dateResult,
      ) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 5, now.month, now.day),
      lastDate: now,
    );
    if (pickedDate != null) {
      dateResult(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateRangeCubit = context.read<DateRangePickerCubit>();
    return Material(
      color: Colors.white,
      child: BlocBuilder<DateRangePickerCubit, DateRangePickerState>(
        builder: (ctx, state) {
          return Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Text('From'),
                    const SizedBox(width: 8),
                    Flexible(
                      child: InkWell(
                        onTap: () => _showDatePicker(
                          context,
                          dateRangeCubit.setFromDate,
                        ),
                        child: Container(
                          width: 156,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(state.fromDateText),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('To'),
                    const SizedBox(width: 8),
                    Flexible(
                      child: InkWell(
                        onTap: () =>
                            _showDatePicker(context, dateRangeCubit.setToDate),
                        child: Container(
                          width: 156,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(state.toDateText),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    state.fromDate != null || state.toDate != null
                        ? IconButton(
                      onPressed: () {
                        onSearchByDateRange();
                        dateRangeCubit.clearDateRange();
                      },
                      icon: const Iconify(Ph.x_circle_light),
                    )
                        : Container(),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
              SizedBox(
                width: 128,
                child: OutlinedButton(
                  onPressed: () =>
                  state.fromDate != null && state.toDate != null
                      ? onSearchByDateRange(
                    fromDate: state.fromDate,
                    toDate: state.toDate,
                  )
                      : {},
                  child: const Row(
                    children: [
                      Iconify(Carbon.search),
                      SizedBox(width: 8),
                      Text(
                        'Search',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}