import 'package:dependencies/intl/intl.dart';

class DateUtils2 {
  const DateUtils2._();

  static String changeDateFormat(
    String? date, {
    required String oldFormat,
    required String newFormat,
  }) {
    try {
      final oldDateFormat = DateFormat(oldFormat);
      final newDateFormat = DateFormat(newFormat);
      return date != null
          ? newDateFormat.format(oldDateFormat.parse(date, true).toLocal())
          : '';
    } catch (e) {
      return '';
    }
  }

  static String changeTimeFormat(
    String? date, {
    String dateFormat = 'yyyy-MM-dd HH:mm:ss',
  }) {
    return changeDateFormat(date, oldFormat: dateFormat, newFormat: 'HH:mm');
  }
}
