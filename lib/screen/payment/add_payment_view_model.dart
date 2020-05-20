import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/screen/payment/add_payment_screen.dart';

abstract class AddPaymentViewModel extends State<AddPaymentScreen> {
  DateTime date = DateTime.now();
  var amountController = TextEditingController();
  var noteController = TextEditingController();
  bool isFirst = true;
  SalesBooking sb;

  Future<Null> actionRefresh() async {
    return null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.args(context) != null && isFirst) {
      var arg = Get.args(context) as Map<String, dynamic>;
      sb = SalesBooking.fromJson(arg);
      isFirst = false;
      actionRefresh();
    }
  }
}