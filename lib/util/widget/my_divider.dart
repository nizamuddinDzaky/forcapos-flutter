import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/util/resource/my_color.dart';

class MyDivider {
  static spaceDividerLogin({double custom}) {
    return Padding(padding: EdgeInsets.symmetric(vertical: custom ?? 6));
  }

  static lineDivider({
    double custom,
    Color customColor,
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Container(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: Divider(
        height: custom ?? 1,
        color: customColor ?? MyColor.lineDivider,
      ),
    );
  }
}
