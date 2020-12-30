import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/app/my_app.dart';
import 'package:timeago/timeago.dart' as timeAGo;

const isProd = kReleaseMode;

void main() async {
  Intl.defaultLocale = Intl.verifiedLocale(Platform.localeName, NumberFormat.localeExists,
      onFailure: (_) => 'en_US');
  initializeDateFormatting();
  await initializeDateFormatting('in_ID', null);
  timeAGo.setLocaleMessages('id', timeAGo.IdMessages());
  ApiClient.addInterceptor();
  return runApp(MyApp());
}