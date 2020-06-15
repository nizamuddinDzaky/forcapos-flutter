import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/delivery.dart';
import 'package:posku/model/delivery_item.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/screen/delivery/return_delivery_screen.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class ReturnDeliveryViewModel extends State<ReturnDeliveryScreen> {
  bool isFirst = true;
  SalesBooking sb;
  Customer customer;
  Delivery delivery;
  List<DeliveryItem> deliveryItems = [];
  DateTime currentDate = DateTime.now();
  var refNoController = TextEditingController();
  var refNoDeliveryController = TextEditingController();
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
        deliveryItems?.forEach((di) {
          di.tempQty = di.quantitySent;
        });
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

  actionPostReturnDelivery(Map body) async {
    var params = {
      MyString.KEY_ID_DELIVERIES_BOOKING: delivery.id,
    };
    var status = await ApiClient.methodPost(
      ApiConfig.urlReturnDeliveriesBooking,
      body,
      params,
      onBefore: (status) {},
      onSuccess: (data, _) {
        Get.snackbar('Retur Pengiriman', 'Berhasil ditambahkan');
        Get.back(result: 'addReturn');
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
      'sale_id': sb?.id ?? '',
      'sale_reference_no': sb?.referenceNo ?? '',
      'do_reference_no': delivery?.doReferenceNo ?? '',
      'note': noteController.text,
      'status': delivery.status,
      'products': deliveryItems.map((item) {
        return {
          'delivery_items_id': item.id,
          'return_quantity': item.quantitySent,
          'delivered_quantity': item.tempQty,
        };
      }).toList(),
    };
    print('return delivery $body');
    await actionPostReturnDelivery(body);
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
      customerController.text = customer?.company;
      addressController.text = customer?.address;
      noteController.text = delivery.note;
      refNoDeliveryController.text = delivery.doReferenceNo;
      refNoController.text = delivery.saleReferenceNo;
      isFirst = false;
    }
  }
}
