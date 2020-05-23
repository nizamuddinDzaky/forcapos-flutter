import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:intl/intl.dart';
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
      var dateFormatOut = DateFormat('MMMM yyyy');
      return dateFormatOut.format(this);
    }
    var dateFormatOut = DateFormat('MMMM');
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
    default:
      return ['Tunai', MyColor.mainRed];
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
      return ['Jatuh tempo', MyColor.mainOrange];
    default:
      return ['Menunggu', MyColor.mainRed];
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
    case 'done':
      return ['Sudah diterima', MyColor.mainGreen];
    case 'returned':
      return ['Dikembalikan', MyColor.mainOrange];
    case 'pending':
      return ['Menunggu', MyColor.mainRed];
    default:
      return [status?.capitalize() ?? '-', MyColor.mainRed];
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T f(E e, int i)) {
    var i = 0;
    return this.map((e) => f(e, i++));
  }
}
