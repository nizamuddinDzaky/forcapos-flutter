import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/screen/customergroup/customer_group_screen.dart';

abstract class CustomerGroupViewModel extends State<CustomerGroupScreen> {
  List<Customer> listCustomer = [];
  bool isFirst = true;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> actionRefresh() async {
    var status = await ApiClient.methodGet(ApiConfig.urlListCustomer,
        onBefore: (status) {
    }, onSuccess: (data, flag) {
      isFirst = false;
      var baseResponse = BaseResponse.fromJson(data);
      listCustomer.clear();
      listCustomer.addAll(baseResponse?.data?.listCustomers ?? []);
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {
    });
    setState(() {
      status.execute();
    });
    return null;
  }

  @override
  void initState() {
    actionRefresh();
    super.initState();
  }
}
