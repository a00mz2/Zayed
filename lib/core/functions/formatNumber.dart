import 'package:intl/intl.dart';

String formatNumber(int originalNumber) {
  String formattedNumber = NumberFormat.simpleCurrency(
    name: "",
    decimalDigits: 0,
  ).format(originalNumber);

  return formattedNumber.toString();
}

String formatNumberNum(num number, {int? decimalDigits}) {
  final digits = decimalDigits ?? ((number % 1 == 0) ? 0 : 2);

  final formatted = NumberFormat.simpleCurrency(
    name: "",
    decimalDigits: digits,
  ).format(number);

  return formatted;
}

int parseFormattedNumber(String value) {
  // إزالة أي شيء غير رقم
  final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');

  if (cleaned.isEmpty) return 0;

  return int.parse(cleaned);
}

double roundUp(double value, {double? step = 250.0}) {
  return (value / step!).ceil() * step;
}
