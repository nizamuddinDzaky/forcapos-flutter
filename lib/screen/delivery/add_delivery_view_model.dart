import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/screen/delivery/add_delivery_screen.dart';

abstract class AddDeliveryViewModel extends State<AddDeliveryScreen> {
  DateTime date = DateTime.now();
  bool isFirst = true;
  SalesBooking sb;
  String statusDelivery = 'packing';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.args(context) != null && isFirst) {
      var arg = Get.args(context) as Map<String, dynamic>;
      sb = SalesBooking.fromJson(arg);
      isFirst = false;
    }
  }
}