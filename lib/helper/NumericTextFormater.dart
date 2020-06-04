import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumericTextFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newInput) {
    final f = new NumberFormat("#,###", 'id');
    var newValue = newInput.text;
    newValue = newValue.replaceAll(RegExp(r'[ ,-]'), '');
    var minus = newInput.text.length - newValue.length;
    if (newValue.length == 0) {
      return newInput.copyWith(text: '');
    } else if (newInput.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight = newValue.length - newInput.selection.end;
      int num = int.parse(newValue.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(num);
      return new TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(offset: newString.length - selectionIndexFromTheRight - minus),
      );
    } else {
      return newInput;
    }
  }
}