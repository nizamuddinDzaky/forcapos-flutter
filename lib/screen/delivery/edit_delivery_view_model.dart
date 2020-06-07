import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/company.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/delivery.dart';
import 'package:posku/model/delivery_item.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/screen/delivery/edit_delivery_screen.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_pref.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class EditDeliveryViewModel extends State<EditDeliveryScreen> {
  bool isFirst = true;
  SalesBooking sb;
  Customer customer;
  Company company;
  Delivery delivery;
  List<DeliveryItem> deliveryItems = [];
  DateTime currentDate = DateTime.now();
  var refNoController = TextEditingController();
  var refNoDeliveryController = TextEditingController();
  var deliveredController = TextEditingController();
  var receivedController = TextEditingController();
  var customerController = TextEditingController();
  var addressController = TextEditingController();
  var noteController = TextEditingController();
  var qtySentController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<Delivery> getDetailDelivery() async {
    var params = {
      MyString.KEY_ID_DELIVERY: delivery?.id ?? '',
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailDeliveries,
      params: params,
      onBefore: (status) {
        print('onbefore');
      },
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        delivery = baseResponse?.data?.delivery ?? Delivery();
        deliveryItems = baseResponse?.data?.deliveryItems ?? [];
      },
      onFailed: (title, message) {
        print('onfailed');
      },
      onError: (title, message) {
        print('onerror');
      },
      onAfter: (status) {
        print('onafter');
        setState(() {});
      },
    );
    status.execute();
    return null;
  }

  actionPutDelivery(Map body) async {
    var params = {
      MyString.KEY_ID_DELIVERIES_BOOKING: delivery.id,
    };
    var status = await ApiClient.methodPut(
      ApiConfig.urlEditDeliveriesBooking,
      body,
      params,
      onBefore: (status) {},
      onSuccess: (data, _) {
        Get.snackbar('Pengiriman', 'Berhasil diperbaharui');
        Get.back(result: 'editDelivery');
      },
      onFailed: (title, message) {
        var errorData = BaseResponse.fromJson(jsonDecode(message));
        CustomDialog.showAlertDialog(context,
            title: title,
            message: 'Kode error: ${errorData?.code}',
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

  actionSubmit() async {
    formKey.currentState.save();
    FocusScope.of(context).requestFocus(new FocusNode());
    var body = {
      'date': currentDate.toStr(),
      'customer': customerController.text,
      'address': addressController.text,
      'status': delivery.status,
      'delivered_by': deliveredController.text,
      'received_by': receivedController.text,
      'note': noteController.text,
      'products': deliveryItems.map((item) {
        return {
          'delivery_items_id': item.id,
          'sent_quantity': item.quantitySent,
        };
      }).toList(),
    };
    print('edit delivery $body');
    await actionPutDelivery(body);
  }

  lastCursorQty(TextEditingController qtyController, double newQty) {
    var newValue = MyNumber.toNumberId(newQty);
    qtyController.value = TextEditingValue(
      text: newValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: newValue.length),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.arguments != null && isFirst) {
      var arg = Get.arguments as Map<String, dynamic>;
      sb = arg['sale'];
      customer = arg['customer'];
      delivery = arg['delivery'];
      getDetailDelivery();
      company = MyPref.getCompany();
      deliveredController.text = company.name;
      receivedController.text = customer.name;
      customerController.text = customer.company;
      addressController.text = customer.address;
      noteController.text = delivery.note;
      refNoDeliveryController.text = delivery.doReferenceNo;
      refNoController.text = delivery.saleReferenceNo;
      currentDate = delivery.date.toDateTime();
      isFirst = false;
    }
  }
}
