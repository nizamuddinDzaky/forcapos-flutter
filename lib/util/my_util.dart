import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/resource/my_color.dart';

bool get isIos => foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);

String strToDate(String txtDate, {BuildContext context}) {
  if (txtDate == null) return '';
  var dateFormatOut = DateFormat('dd MMMM yyyy', 'in_ID');
  return dateFormatOut.format(DateTime.tryParse(txtDate));
}

String strToDateMMM(String txtDate, {BuildContext context}) {
  if (txtDate == null) return '';
  var dateFormatOut = DateFormat('dd MMM yyyy', 'in_ID');
  return dateFormatOut.format(DateTime.tryParse(txtDate));
}

String strToDateTimeFormat(String txtDate, {BuildContext context}) {
  if (txtDate == null) return '';
  var dateFormatOut = DateFormat('dd MMMM yyyy HH:mm', 'in_ID');
  return dateFormatOut.format(DateTime.tryParse(txtDate));
}

extension DateTimeExtension on DateTime {
  String toStr() {
    if (this == null) return '';
    var dateFormatOut = DateFormat('yyyy-MM-dd HH:mm:ss');
    return dateFormatOut.format(this);
  }

  String toMonthStr({bool showDiffYear = false}) {
    if (this == null) return '';
    var now = DateTime.now();
    if (showDiffYear && now.year != this.year) {
      var dateFormatOut = DateFormat('MMMM yyyy', 'in_ID');
      return dateFormatOut.format(this);
    }
    var dateFormatOut = DateFormat('MMMM', 'in_ID');
    return dateFormatOut.format(this);
  }
}

String dateToDate(DateTime dateTime) {
  if (dateTime == null) return '';
  var dateFormatOut = DateFormat('dd MMMM yyyy', 'in_ID');
  return dateFormatOut.format(dateTime);
}

String differenceDateTime(DateTime startDate, DateTime endDate) {
//  if (endDate.millisecondsSinceEpoch > startDate.millisecondsSinceEpoch) {
    var diff = endDate.difference(startDate);
    return '${diff.inDays} hari';
//  }
//  return dateFormatOut.format(dateTime);
}

paidType(String type) {
  switch(type?.toLowerCase()) {
    case 'cash':
      return ['Tunai', MyColor.mainRed];
    case 'bank':
      return ['Transfer Bank', MyColor.mainRed];
    default:
      return [type, MyColor.mainRed];
  }
}

saleStatus(String status) {
  switch(status?.toLowerCase()) {
    case 'reserved':
      return ['Dipesan', MyColor.blueDio];
    case 'closed':
      return ['Selesai', MyColor.mainGreen];
    default:
      return ['Menunggu', MyColor.mainRed];
  }
}

paymentStatus(String status) {
  switch(status?.toLowerCase()) {
    case 'paid':
      return ['Lunas', MyColor.mainGreen];
    case 'partial':
      return ['Sebagian', MyColor.mainBlue];
    case 'due':
      return ['Jatuh tempo', MyColor.mainRed];
    default:
      return ['Menunggu', MyColor.mainOrange];
  }
}

purchaseStatus(String status) {
  switch(status?.toLowerCase()) {
    case 'received':
      return ['Diterima', MyColor.mainGreen];
    case 'returned':
      return ['Return', MyColor.mainRed];
    case 'partial':
      return ['Sebagian', MyColor.mainBlue];
    default:
      return ['Menunggu', MyColor.mainOrange];
  }
}

deliveryStatus(String status) {
  switch(status?.toLowerCase()) {
    case 'packing':
      return ['Dikemas', MyColor.mainBlue];
    case 'delivering':
      return ['Sedang dikirim', MyColor.blueDio];
    case 'partial':
      return ['Sebagian', MyColor.blueDio];
    case 'delivered':
    case 'done':
      return ['Selesai', MyColor.mainGreen];
    case 'returned':
      return ['Dikembalikan', MyColor.mainOrange];
    case 'pending':
      return ['Menunggu', MyColor.mainRed];
    default:
      return [status?.capitalize() ?? '-', MyColor.mainRed];
  }
}

saleDeliveryStatus(String status) {
  switch(status?.toLowerCase()) {
    case 'packing':
      return ['Dikemas', MyColor.mainBlue];
    case 'delivering':
      return ['Sedang dikirim', MyColor.blueDio];
    case 'partial':
      return ['Diterima sebagian', MyColor.blueDio];
    case 'delivered':
      return ['Sudah diterima', MyColor.mainGreen];
    case 'done':
      return ['Selesai', MyColor.mainGreen];
    case 'returned':
      return ['Dikembalikan', MyColor.mainOrange];
    case 'pending':
      return ['Menunggu', MyColor.mainRed];
    default:
      return [status?.capitalize() ?? '-', MyColor.mainRed];
  }
}

extension StringExtension on String {
  String toAlias() {
    var txt = this?.trim()?.toUpperCase();
    if (txt == null || txt.isEmpty) return '#';
    if (txt.length == 1) return txt;
    return txt.substring(0, 2);
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  DateTime toDateTime() {
    var dateFormatIn = DateFormat('yyyy-MM-dd HH:mm:ss');
    var newDate = DateTime.now();
    try {
      newDate = dateFormatIn.parse(this);
    } catch (e) {
      print(e.message);
    }
    return newDate;
  }

  String toRp() {
    return MyNumber.toNumberRpStr(this);
  }

  String toNumId() {
    return MyNumber.toNumberIdStr(this);
  }

  String toDecId() {
    return MyNumber.toDecimalIdStr(this);
  }

  double toDouble() {
    return MyNumber.strUSToDouble(this);
  }

  double toDoubleID() {
    return MyNumber.strIDToDouble(this);
  }

  String strDoubleID() {
    return MyNumber.strIDToDouble(this).toString();
  }

  double tryIDtoDouble() {
    return MyNumber.tryStrIDToDouble(this);
  }

  double tryToDouble() {
    return MyNumber.tryStrUSToDouble(this);
  }

  String changeComma() { //format ID
    return this
        .split('')
        .map((e) => e == ',' ? '.' : (e == '.' ? '' : e))
        .join();
  }
}

extension DoubleExtension on double {
  String toRp() {
    return MyNumber.toNumberRpStr(this.toString());
  }

  String toDecId() {
    return MyNumber.toDecimalIdStr(this.toString());
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T f(E e, int i)) {
    var i = 0;
    return this.map((e) => f(e, i++));
  }
}

lastCursorEditText(TextEditingController qtyController, double newQty) {
  var newValue = MyNumber.toNumberId(newQty);
  qtyController.value = TextEditingValue(
    text: newValue,
    selection: TextSelection.fromPosition(
      TextPosition(offset: newValue.length),
    ),
  );
}

dynamic getArg(index, {myArg}) {
  var arg = myArg ?? Get.arguments;
  if (arg == null) return null;
  if (arg is Map) {
    return arg[index];
  }
}

putArg(arg, index, result) {
  if (arg is Map) {
    arg[index] = result;
  }
}

tryJsonDecode(String jsonString) {
  try {
    return jsonDecode(jsonString);
  } catch (_) {
  }
  return null;
}

tryJsonEncode(Object value) {
  try {
    return jsonEncode(value);
  } catch (_) {
  }
  return null;
}