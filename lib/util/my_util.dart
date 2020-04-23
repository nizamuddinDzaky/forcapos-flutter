import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:intl/intl.dart';

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