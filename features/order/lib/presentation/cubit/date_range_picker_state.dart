import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/intl/intl.dart';
import 'package:resources/constants/constant.dart';

class DateRangePickerState extends Equatable {
  final DateTime? fromDate;
  final DateTime? toDate;
  final String fromDateText;
  final String toDateText;

  const DateRangePickerState({
    this.fromDate,
    this.toDate,
    this.fromDateText = '',
    this.toDateText = '',
  });

  DateRangePickerState copyWith({
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    final dateFormat = DateFormat(DateTimeConst.defaultDateFormat);
    final fromDate0 = fromDate ?? this.fromDate;
    final toDate0 = toDate ?? this.toDate;
    return DateRangePickerState(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      fromDateText: fromDate0 != null ? dateFormat.format(fromDate0) : '',
      toDateText: toDate0 != null ? dateFormat.format(toDate0) : '',
    );
  }

  @override
  List<Object?> get props => [
        fromDate,
        toDate,
        fromDateText,
        toDateText,
      ];
}
