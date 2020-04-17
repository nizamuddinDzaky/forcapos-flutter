import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';

class MyNumber {
  static var fmf = new FlutterMoneyFormatter(
      amount: 0,
      settings: MoneyFormatterSettings(
          symbol: 'Rp',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 0,
          compactFormatType: CompactFormatType.short));

  static String toRupiah(double newValue) {
    final f = NumberFormat('#,###', 'id');
    return fmf
        .copyWith(
            amount: newValue ?? 0,
            symbol: 'Rp.',
            thousandSeparator: f.symbols.GROUP_SEP,
            decimalSeparator: f.symbols.DECIMAL_SEP)
        .output
        .symbolOnLeft;
  }

  static String toNumberId(double newValue) {
    final f = NumberFormat('#,###', 'id');
    return f.format(newValue);
  }

  static String toNumberRp(double newValue) {
//    final f = NumberFormat('#,###', 'id');
    final fc = NumberFormat.currency(locale: 'id', symbol: 'Rp');
//    return f.format(newValue);
    return fc.format(newValue);
  }

  static double strToDouble(String newValue) {
    final f = NumberFormat('#,###', 'id');
    var resValue = (newValue ?? '').isEmpty ? '0' : newValue;
    return f.parse(resValue) ?? 0;
  }

  static double strUSToDouble(String newValue) {
    final f = NumberFormat('#,###');
    var resValue = (newValue ?? '').isEmpty ? '0' : newValue;
    return f.parse(resValue) ?? 0;
  }
}
