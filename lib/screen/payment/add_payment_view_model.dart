import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/screen/payment/add_payment_screen.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/payment_cons.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class AddPaymentViewModel extends State<AddPaymentScreen> {
  DateTime date = DateTime.now();
  var amountController = TextEditingController();
  var noteController = TextEditingController();
  bool isFirst = true;
  SalesBooking sb;
  List<dynamic> paymentType = ['', 'cash', PaymentType.cash];

  actionPostPayment(Map<String, String> body) async {
    var params = {
      MyString.KEY_ID_SALES_BOOKING: sb.id,
    };
    var status = await ApiClient.methodPost(
      ApiConfig.urlAddPaymentBooking,
      body,
      params,
      onBefore: (status) {},
      onSuccess: (data, _) {
        Get.snackbar('Pembayaran', 'Berhasil ditambahkan');
        Get.back(result: 'newPayment');
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
      sb = SalesBooking.fromJson(arg);
      var unpaid = MyNumber.strUSToDouble(sb.grandTotal) -
          MyNumber.strUSToDouble(sb.paid);
      amountController.text = MyNumber.toNumberId(unpaid);
      isFirst = false;
    }
  }
}
