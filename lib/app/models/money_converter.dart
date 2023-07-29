import 'package:intl/intl.dart';

String convertNumberToMoney(double number, double absNumber) {
  String formattedAmount = NumberFormat.currency(
    symbol: (number >= 0) ? 'Rp ' : 'Rp -',
    decimalDigits: 2,
  ).format(absNumber);
  return formattedAmount;
}
