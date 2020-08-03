import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/company.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/model/sales_booking_item.dart';
import 'package:posku/screen/delivery/add_delivery_screen.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_pref.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class AddDeliveryViewModel extends State<AddDeliveryScreen> {
  DateTime date = DateTime.now();
  bool isFirst = true;
  SalesBooking sb;
  Customer customer;
  Company company;
  List<SalesBookingItem> sbItems = [];
  String statusDelivery = 'packing';
  var refNoController = TextEditingController();
  var deliveredController = TextEditingController();
  var receivedController = TextEditingController();
  var customerController = TextEditingController();
  var addressController = TextEditingController();
  var noteController = TextEditingController();
  var qtySentController = TextEditingController();

  actionPostDelivery(Map body) async {
    var params = {
      MyString.KEY_ID_SALES_BOOKING: sb.id,
    };
    var status = await ApiClient.methodPost(
      ApiConfig.urlAddDeliveriesBooking,
      body,
      params,
      onBefore: (status) {},
      onSuccess: (data, _) {
        Get.snackbar('Pengiriman', 'Berhasil ditambahkan');
        Get.back(result: 'newDelivery');
      },
      onFailed: (title, message) {
        var errorData = BaseResponse.fromJson(jsonDecode(message));
        CustomDialog.showAlertDialog(context,
            title: title,
            message: 'Kode error: ${errorData?.code}\n${errorData?.message}',
            leftAction: CustomDialog.customAction());
      },
      onError: (title, message) {
        CustomDialog.showAlertDialog(context,
            title: title,
            message: message,
            leftAction: CustomDialog.customAction());
      },
      onAfter: (status) {},
    );
    status.execute();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.arguments != null && isFirst) {
      var arg = Get.arguments as Map<String, dynamic>;
      sb = arg['sale'];
      customer = arg['customer'];
      List<SalesBookingItem> originSbItems = arg['sbItems'];
      sbItems.addAll(originSbItems?.map((sbi) {
        var qtyUnsent = MyNumber.strUSToDouble(sbi.quantity) -
            MyNumber.strUSToDouble(sbi.sentQuantity);
        return sbi..unitQuantity = qtyUnsent.toString();
      })?.toList() ?? []);
      company = MyPref.getCompany();
      deliveredController.text = company.name;
      receivedController.text = customer?.name;
      customerController.text = customer?.company;
      addressController.text = customer?.address;
      isFirst = false;
    }
  }
}