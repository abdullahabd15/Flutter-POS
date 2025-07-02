import 'package:dependencies/intl/intl.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

extension DoubleExtension on double? {
  String convertToCurrency() {
    final Locale locale = const Locale('id-ID');
    try {
      final double number = this ?? 0.0;
      final format = NumberFormat.currency(
        locale: locale.toString(),
        symbol: NumberFormat.simpleCurrency(
          locale: locale.toString(),
        ).currencySymbol,
        decimalDigits: 0,
      );
      return format.format(number);
    } catch (e) {
      return '${NumberFormat.simpleCurrency(locale: locale.toString()).currencySymbol}0';
    }
  }
}

extension SharedPreferencesExtension on SharedPreferences {
  Future<void> saveToken(String value) async {
    await setString('token', value);
  }

  Future<String?> getToken() async {
    return getString('token');
  }
}
