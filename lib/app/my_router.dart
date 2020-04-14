import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/screen/login/forgot_password_screen.dart';
import 'package:posku/screen/login/login_screen.dart';
import 'package:posku/screen/splash_screen.dart';

const String root = "/";
const loginScreen = "/LoginScreen";
const forgotPasswordScreen = "/ForgotPasswordScreen";

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return GetRoute(
          page: SplashScreen(),
          settings: settings,
        );
      case loginScreen:
        return GetRoute(
          settings: settings,
          transition: Transition.fade,
          page: LoginScreen(),
        );
      case forgotPasswordScreen:
        return GetRoute(
          settings: settings,
          page: ForgotPasswordScreen(),
        );
      default:
        return GetRoute(
            settings: settings,
            transition: Transition.fade,
            page: Scaffold(
              body:
              Center(child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}