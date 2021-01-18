import 'package:flutter/cupertino.dart';
import 'package:posku/util/payment_cons.dart';

import 'add_payment_purchase.dart';

abstract class AddPaymentPurchaseViewModel extends State<AddPaymentPurchaseScreen> {

  DateTime date = DateTime.now();
  var amountController = TextEditingController();
  var noteController = TextEditingController();
  List<dynamic> paymentType = ['', 'cash', PaymentType.cash];
}