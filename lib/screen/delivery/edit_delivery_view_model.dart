import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posku/model/company.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/delivery.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/model/sales_booking_item.dart';
import 'package:posku/screen/delivery/edit_delivery_screen.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_pref.dart';
import 'package:posku/util/my_util.dart';

abstract class EditDeliveryViewModel extends State<EditDeliveryScreen> {
  bool isFirst = true;
  SalesBooking sb;
  Customer customer;
  Company company;
  Delivery delivery;
  List<SalesBookingItem> sbItems = [];
  DateTime currentDate = DateTime.now();
  var refNoController = TextEditingController();
  var refNoDeliveryController = TextEditingController();
  var deliveredController = TextEditingController();
  var receivedController = TextEditingController();
  var customerController = TextEditingController();
  var addressController = TextEditingController();
  var noteController = TextEditingController();
  var qtySentController = TextEditingController();

  actionPutDelivery(body) async {}

  actionSubmit() async {
    var body = {
      'date': currentDate.toStr(),
      'sale_reference_no': refNoController.text,
      'customer': customerController.text,
      'address': addressController.text,
      'status': delivery.status,
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
    print('edit delivery $body');
    await actionPutDelivery(body);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.arguments != null && isFirst) {
      var arg = Get.arguments as Map<String, dynamic>;
      sb = arg['sale'];
      customer = arg['customer'];
      delivery = arg['delivery'];
      List<SalesBookingItem> originSbItems = arg['sbItems'];
      sbItems.addAll(originSbItems.map((sbi) {
        var qtySent = MyNumber.strUSToDouble(sbi.sentQuantity);
        return sbi..unitQuantity = qtySent.toString();
      }).toList());
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
