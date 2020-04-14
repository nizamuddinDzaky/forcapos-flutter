import 'package:flutter/cupertino.dart';

class MyDivider {
  static spaceDividerLogin({double custom}) {
    return Padding(padding: EdgeInsets.symmetric(vertical: custom ?? 9));
  }
}