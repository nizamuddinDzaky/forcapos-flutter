import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/payment.dart';
import 'package:posku/screen/payment/edit_payment_screen.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/payment_cons.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class EditPaymentViewModel extends State<EditPaymentScreen> {
  DateTime date = DateTime.now();
  var amountController = TextEditingController();
  var noteController = TextEditingController();
  bool isFirst = true;
  Payment payment;
  List<dynamic> paymentType = listPaymentType[0];

  actionPutPayment(Map<String, String> body) async {
    var params = {
      MyString.KEY_ID_PAYMENT: payment.id,
    };
    var status = await ApiClient.methodPut(
      ApiConfig.urlEditPaymentBooking,
      body,
      params,
      onBefore: (status) {},
      onSuccess: (data, _) {
        Get.snackbar('Pembayaran', 'Berhasil diperbaharui');
        Get.back(result: 'editPayment');
      },
      onFailed: (title, message) {
        print(message);
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

  submitChanges() async {
    var amount = MyNumber.strIDToDouble(amountController.text);
    if (amount > 0) {
      Map<String, String> body = {
        'amount_paid': amount.toString(),
        'note': noteController.text,
        'date': date.toStr(),
        'payment_method': paymentType[1],
      };
      print('cek data put $body');
      await actionPutPayment(body);
    } else {
      Get.defaultDialog(
        title: 'Mohon Maaf',
        content: Text('Jumlah tidak boleh kosong/nol'),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.arguments != null && isFirst) {
      var arg = Get.arguments as Map<String, dynamic>;
      if (arg == null) return;
      payment = Payment.fromJson(arg['payment']);
      amountController.text = MyNumber.toNumberIdStr(payment.amount);
      noteController.text = payment.note?.trim();
      listPaymentType?.forEach((element) {
        if (element[1] == payment.paidBy) {
          paymentType = element;
        }
      });
      date = payment.date?.toDateTime() ?? date;
      isFirst = false;
    }
  }
}
