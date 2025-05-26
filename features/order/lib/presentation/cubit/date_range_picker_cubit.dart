import 'package:dependencies/bloc/bloc.dart';
import 'package:order/presentation/cubit/date_range_picker_state.dart';

class DateRangePickerCubit extends Cubit<DateRangePickerState> {
  DateRangePickerCubit() : super(const DateRangePickerState());

  void setFromDate(DateTime date) {
    emit(state.copyWith(fromDate: date));
  }

  void setToDate(DateTime date) {
    emit(state.copyWith(toDate: date));
  }

  void clearDateRange() {
    emit(const DateRangePickerState());
  }
}
