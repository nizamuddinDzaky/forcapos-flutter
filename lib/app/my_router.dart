import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/helper/custom_cupertino_page_route.dart';
import 'package:posku/screen/customer/add_customer_screen.dart';
import 'package:posku/screen/customer/detail_customer_screen.dart';
import 'package:posku/screen/customer/edit_customer_screen.dart';
import 'package:posku/screen/customergroup/add_customer_to_cg_screen.dart';
import 'package:posku/screen/customergroup/add_edit_cg_screen.dart';
import 'package:posku/screen/delivery/add_delivery_screen.dart';
import 'package:posku/screen/delivery/detail_delivery_screen.dart';
import 'package:posku/screen/delivery/edit_delivery_screen.dart';
import 'package:posku/screen/delivery/return_delivery_screen.dart';
import 'package:posku/screen/filter/filter_screen.dart';
import 'package:posku/screen/goodreceived/gr_confirmation_screen.dart';
import 'package:posku/screen/goodreceived/gr_detail_screen.dart';
import 'package:posku/screen/home/home_screen.dart';
import 'package:posku/screen/login/forgot_password_screen.dart';
import 'package:posku/screen/login/login_screen.dart';
import 'package:posku/screen/payment/add_payment_screen.dart';
import 'package:posku/screen/payment/detail_payment_screen.dart';
import 'package:posku/screen/payment/edit_payment_screen.dart';
import 'package:posku/screen/pricegroup/add_customer_to_pg_screen.dart';
import 'package:posku/screen/pricegroup/add_edit_pg_screen.dart';
import 'package:posku/screen/pricegroup/pg_detail_screen.dart';
import 'package:posku/screen/profile/profile_screen.dart';
import 'package:posku/screen/purchase/add_payment_purchase.dart';
import 'package:posku/screen/purchase/add_purchase_screen.dart';
import 'package:posku/screen/purchase/edit_purchase_screen.dart';
import 'package:posku/screen/purchase/list_purchase_screen.dart';
import 'package:posku/screen/purchase/add_product_purchase_screen.dart';
import 'package:posku/screen/purchase/purchase_cart_screen.dart';
import 'package:posku/screen/purchase/purchase_detail_screen.dart';
import 'package:posku/screen/salebooking/add_sales_booking_screen.dart';
import 'package:posku/screen/salebooking/edit_sales_booking_screen.dart';
import 'package:posku/screen/salebooking/edit_sb_item_screen.dart';
import 'package:posku/screen/salebooking/edit_sb_product_screen.dart';
import 'package:posku/screen/salebooking/sb_cart_screen.dart';
import 'package:posku/screen/salebooking/sb_detail_screen.dart';
import 'package:posku/screen/salebooking/sb_item_screen.dart';
import 'package:posku/screen/salebooking/sb_order_screen.dart';
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
const profileScreen = "/ProfileScreen";
const editPaymentScreen = "/EditPaymentScreen";
const editDeliveryScreen = "/EditDeliveryScreen";
const addSalesBookingScreen = "/AddSalesBookingScreen";
const salesBookingOrderScreen = "/SalesBookingOrderScreen";
const salesBookingCartScreen = "/SalesBookingCartScreen";
const salesBookingItemScreen = "/SalesBookingItemScreen";
const editSalesBookingScreen = "/EditSalesBookingScreen";
const editSBProductScreen = "/EditSBProductScreen";
const editSBItemScreen = "/EditSBItemScreen";
const returnDeliveryScreen = "/ReturnDeliveryScreen";
const addCustomerToCGScreen = "/AddCustomerToCGScreen";
const addCustomerToPGScreen = "/AddCustomerToPGScreen";
const addEditPGScreen = "/AddEditPGScreen";
const addEditCGScreen = "/AddEditCGScreen";
const addCustomerScreen = "/AddCustomerScreen";
const editCustomerScreen = "/EditCustomerScreen";
const listPurchase = "/ListPurchaseScreen";
const addPurchase = "/AddPurchaseScreen";
const addProductPurchase = "/AddProductPurchaseScreen";
const purchaseCart = "/PurchaseCartScreen";
const purchaseDetail = "/PurchaseDetailScreen";
const editPurchaseScreen = "/EditPurchaseScreen";
const addPaymentPurchaseScreen = "/AddPaymentPurchaseScreen";

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return GetRouteBase(
          page: SplashScreen(),
          settings: settings,
        );
      case loginScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.fade,
          page: LoginScreen(),
        );
      case forgotPasswordScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: ForgotPasswordScreen(),
        );
      case homeScreen:
        return GetRouteBase(
          settings: RouteSettings(name: homeScreen, arguments: Map()),
          transition: Transition.rightToLeft,
          page: HomeScreen(),
        );
      case grConfirmationScreen:
        return GetRouteBase(
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
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: FilterScreen(),
        );
      case detailPaymentScreen:
        return GetRouteBase(
          settings: settings,
          fullscreenDialog: true,
          page: DetailPaymentScreen(),
        );
      case detailCustomerScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: DetailCustomerScreen(),
        );
      case pgDetailScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: PGDetailScreen(),
        );
      case addPaymentScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: AddPaymentScreen(),
        );
      case addDeliveryScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: AddDeliveryScreen(),
        );
      case profileScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: ProfileScreen(),
        );
      case editPaymentScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: EditPaymentScreen(),
        );
      case editDeliveryScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: EditDeliveryScreen(),
        );
      case addSalesBookingScreen:
        return GetRouteBase(
          settings: settings,
          fullscreenDialog: true,
          page: AddSalesBookingScreen(),
        );
      case salesBookingOrderScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: SalesBookingOrderScreen(),
        );
      case salesBookingCartScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: SalesBookingCartScreen(),
        );
      case salesBookingItemScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: SalesBookingItemScreen(),
        );
      case editSalesBookingScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: EditSalesBookingScreen(),
        );
      case editSBProductScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: EditSBProductScreen(),
        );
      case editSBItemScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: EditSBItemScreen(),
        );
      case returnDeliveryScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: ReturnDeliveryScreen(),
        );
      case addCustomerToCGScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: AddCustomerToCGScreen(),
        );
      case addCustomerToPGScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: AddCustomerToPGScreen(),
        );
      case addEditPGScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: AddEditPGScreen(),
        );
      case addEditCGScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: AddEditCGScreen(),
        );
      case addCustomerScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: AddCustomerScreen(),
        );
      case editCustomerScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: EditCustomerScreen(),
        );
      case listPurchase:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: ListPurchaseScreen(),
        );
      case addPurchase:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: AddPurchaseScreen(),
        );
      case addProductPurchase:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: AddProductPurchaseScreen(),
        );
      case purchaseCart:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: PurchaseCartScreen(),
        );
      case purchaseDetail:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: PurchaseDetailScreen(),
        );
      case editPurchaseScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: EditPurchaseScreen(),
        );
      case addPaymentPurchaseScreen:
        return GetRouteBase(
          settings: settings,
          transition: Transition.rightToLeft,
          page: AddPaymentPurchaseScreen(),
        );
      default:
        return GetRouteBase(
            settings: settings,
            transition: Transition.fade,
            page: Scaffold(
              body:
              Center(child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}