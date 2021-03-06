import 'package:flutter/material.dart';
import 'package:posku/util/resource/my_image.dart';

class MyLogo {
  static Widget logoForcaPoS({large = false}) {
    return Image.asset(
      kLogoForcaPoS,
      width: large ? 200 : 120,
      height: large ? null : 56,
      color: Colors.white,
      fit: BoxFit.cover,
    );
  }

  static Widget logoForcaPoSColor({double width}) {
    return Image.asset(
      kLogoForcaPoS,
      fit: BoxFit.cover,
      width: width,
    );
  }

  static Widget forgotPassword() {
    return Image.asset(
      kForgotPassword,
      fit: BoxFit.cover,
    );
  }
}
