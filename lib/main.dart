import 'package:flutter/material.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/app/my_app.dart';
import 'package:posku/util/my_pref.dart';
import 'package:timeago/timeago.dart' as timeAGo;

void main() {
  timeAGo.setLocaleMessages('id', timeAGo.IdMessages());
  ApiClient.addInterceptor();
  return runApp(MyApp());
}