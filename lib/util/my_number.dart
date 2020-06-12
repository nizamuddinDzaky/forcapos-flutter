import 'package:intl/intl.dart';
import 'my_util.dart';

class MyNumber {
  static String toNumberId(double newValue) {
    final f = NumberFormat('#,###', 'id');
    return f.format(newValue);
  }

  static String toDecimalIdStr(String newValue) {
    final f = NumberFormat('#,###.##', 'id');
    return f.format(strUSToDouble(newValue));
  }

  static String toNumberIdStr(String newValue) {
    final f = NumberFormat('#,###', 'id');
    return f.format(strUSToDouble(newValue));
  }

  static String toNumberRp(double newValue) {
    final fc = NumberFormat.currency(locale: 'id', symbol: 'Rp');
    return fc.format(newValue);
  }

  static String toNumberRpStr(String newValue) {
    final fc = NumberFormat.currency(locale: 'id', symbol: 'Rp');
    return fc.format(strUSToDouble(newValue));
  }

  static double strIDToDouble(String newValue) {
    final f = NumberFormat('#,###', 'id');
    var resValue = (newValue ?? '').isEmpty ? '0' : newValue;
    return f.parse(resValue) ?? 0;
  }

  static double strUSToDouble(String newValue) {
    final f = NumberFormat('#,###', 'en');
    var resValue = (newValue ?? '').isEmpty ? '0' : newValue;
    return f.parse(resValue) ?? 0;
  }

  static double tryStrIDToDouble(String newValue) {
    var resValue = (newValue ?? '').isEmpty ? '0' : newValue;
    return double.tryParse(resValue.changeComma()) ?? 0.0;
  }

  static double tryStrUSToDouble(String newValue) {
    var resValue = (newValue ?? '').isEmpty ? '0' : newValue;
    return double.tryParse(resValue) ?? 0.0;
  }
}
