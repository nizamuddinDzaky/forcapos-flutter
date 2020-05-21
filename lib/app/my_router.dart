import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/helper/custom_cupertino_page_route.dart';
import 'package:posku/screen/customer/detail_customer_screen.dart';
import 'package:posku/screen/delivery/add_delivery_screen.dart';
import 'package:posku/screen/delivery/detail_delivery_screen.dart';
import 'package:posku/screen/filter/filter_screen.dart';
import 'package:posku/screen/goodreceived/gr_confirmation_screen.dart';
import 'package:posku/screen/goodreceived/gr_detail_screen.dart';
import 'package:posku/screen/home/home_screen.dart';
import 'package:posku/screen/login/forgot_password_screen.dart';
import 'package:posku/screen/login/login_screen.dart';
import 'package:posku/screen/payment/add_payment_screen.dart';
import 'package:posku/screen/payment/detail_payment_screen.dart';
import 'package:posku/screen/pricegroup/pg_detail_screen.dart';
import 'package:posku/screen/salebooking/sb_detail_screen.dart';
import 'package:posku/screen/splash_screen.dart';

const String root = "/";
const loginScreen = "/LoginScreen";
const forgotPasswordScreen = "/ForgotPasswordScreen";
const homeScreen = "/HomeScreen";
const grConfirmationScreen = "/GrConfirmationScreen";
const grDetailScreen = "/GrDetailScreen";
const sbDetailScreen = "/SbDetailScreen";
const filterScreen = "/FilterScreen";
const detailDeliveryScreen = "/DetailDeliveryScreen";
const detailPaymentScreen = "/DetailPaymentScreen";
const detailCustomerScreen = "/DetailCustomerScreen";
const pgDetailScreen = "/PgDetailScreen";
const addPaymentScreen = "/AddPaymentScreen";
const addDeliveryScreen = "/AddDeliveryScreen";

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
          transition: Transition.rightToLeft,
          page: ForgotPasswordScreen(),
        );
      case homeScreen:
        return GetRoute(
          settings: settings,
          transition: Transition.rightToLeft,
          page: HomeScreen(),
        );
      case grConfirmationScreen:
        return GetRoute(
          settings: settings,
          transition: Transition.rightToLeft,
          page: GRConfirmationScreen(),
        );
      case grDetailScreen:
        return CustomCupertinoPageRoute(
          settings: settings,
          builder: (BuildContext context) => GRDetailScreen(),
        );
      case sbDetailScreen:
        return CustomCupertinoPageRoute(
          settings: settings,
          builder: (BuildContext context) => SBDetailScreen(),
        );
      case detailDeliveryScreen:
        return CustomCupertinoPageRoute(
          settings: settings,
          builder: (BuildContext context) => DetailDeliveryScreen(),
        );
      case filterScreen:
        return GetRoute(
          settings: settings,
          transition: Transition.rightToLeft,
          page: FilterScreen(),
        );
      case detailPaymentScreen:
        return GetRoute(
          settings: settings,
          fullscreenDialog: true,
          page: DetailPaymentScreen(),
        );
      case detailCustomerScreen:
        return GetRoute(
          settings: settings,
          transition: Transition.rightToLeft,
          page: DetailCustomerScreen(),
        );
      case pgDetailScreen:
        return GetRoute(
          settings: settings,
          transition: Transition.rightToLeft,
          page: PGDetailScreen(),
        );
      case addPaymentScreen:
        return GetRoute(
          settings: settings,
          transition: Transition.rightToLeft,
          page: AddPaymentScreen(),
        );
      case addDeliveryScreen:
        return GetRoute(
          settings: settings,
          transition: Transition.rightToLeft,
          page: AddDeliveryScreen(),
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