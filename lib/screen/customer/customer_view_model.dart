import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/screen/customer/customer_screen.dart';

abstract class CustomerViewModel extends State<CustomerScreen> {
  List<Customer> listCustomer = [];
//  List<Customer> listCustomer;
//  bool isFirst = true;
  bool isFirst = false;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> actionRefresh() async {
    return null;
  }

  initData() {
    listCustomer.addAll([
      Customer(),
      Customer(),
      Customer(),
      Customer(),
    ]);
  }

  @override
  void initState() {
    super.initState();
    initData();
  }
}
