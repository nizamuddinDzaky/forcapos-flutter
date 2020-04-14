import 'package:flutter/cupertino.dart';

class MyDimen {
  /// text field
  static EdgeInsetsGeometry paddingRememberPass() =>
      EdgeInsets.only(left: 8, right: 8);

  static EdgeInsetsGeometry paddingTxtField() =>
      EdgeInsets.symmetric(horizontal: 8);

  static EdgeInsetsGeometry marginLayout() =>
      EdgeInsets.symmetric(horizontal: 22);

  static double circularMedium = 25;
  static int timerSplash = 1;

  static double paddingFieldLoginSize() => 40;

  static EdgeInsetsGeometry paddingItem() =>
      EdgeInsets.symmetric(horizontal: 16, vertical: 10);

  static EdgeInsetsGeometry paddingFieldLogin() =>
      EdgeInsets.symmetric(horizontal: paddingFieldLoginSize());

  static Size sizeCardTitle() => Size(140, 50);

  static double fontSizeLogoLarge() => 50;

  static double fontSizeLogoMedium() => 30;

  static double circularInput() => 50;
}
