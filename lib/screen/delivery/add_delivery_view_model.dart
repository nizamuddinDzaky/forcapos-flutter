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
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class AddDeliveryViewModel extends State<AddDeliveryScreen> {
  DateTime date = DateTime.now();
  bool isFirst = true;
  String fromAddSales;
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

  actionSubmit() async {
    var body = {
      'date': date.toStr(),
      'sale_reference_no': sb.referenceNo,
      'customer': customerController.text,
      'address': addressController.text,
      'status': statusDelivery,
      'delivered_by': deliveredController.text,
      'received_by': receivedController.text,
      'note': noteController.text,
      'products': sbItems.map((sbi) {
        return {
          'sale_items_id': sbi.id,
          'sent_quantity': sbi.unitQuantity,
        };
      }).toList(),
    };
    debugPrint('new delivery $body');
    actionPostDelivery(body);
  }

  Future<List<SalesBookingItem>> getSalesBookingItem(String idSales) async {
    if (sbItems != null) return sbItems;
    var params = {
      MyString.KEY_ID_SALES_BOOKING: idSales,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailSalesBooking,
      params: params,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        sb = baseResponse?.data?.salesBooking ?? sb;
        sbItems = baseResponse?.data?.salesBookingItems ?? [];
      },
      onAfter: (status) {
        setState(() {});
      },
    );
    status.execute();
    return null;
  }

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
      fromAddSales = arg['fromAddSales'];
      debugPrint('cek fromAddSales $originSbItems $fromAddSales');
      sbItems.addAll(originSbItems?.map((sbi) {
            var qtyUnsent = MyNumber.strUSToDouble(sbi.quantity) -
                MyNumber.strUSToDouble(sbi.sentQuantity);
            debugPrint('isi $qtyUnsent ${sbi.quantity} ${sbi.sentQuantity}');
            return sbi..unitQuantity = qtyUnsent.toString();
          })?.toList() ??
          []);
      company = MyPref.getCompany();
      deliveredController.text = company.name;
      receivedController.text = customer?.name;
      customerController.text = customer?.company;
      addressController.text = customer?.address;
      if (fromAddSales?.isNotEmpty ?? false) {
        sb = null;
        sbItems = null;
        getSalesBookingItem(fromAddSales);
      }
      isFirst = false;
    }
  }
}
