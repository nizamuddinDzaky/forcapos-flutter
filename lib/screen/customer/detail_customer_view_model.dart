import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/screen/customer/detail_customer_screen.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class DetailCustomerViewModel extends State<DetailCustomerScreen> {
  bool isFirst = true;
  String id;
  Customer customer;

  Future<Null> actionRefresh() async {
    var params = {
      MyString.KEY_ID_CUSTOMER: id,
    };
    var status = await ApiClient.methodGet(ApiConfig.urlDetailCustomer,
        params: params, onBefore: (status) {}, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      customer = baseResponse?.data?.customer;
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {
      setState(() {});
    });
    setState(() {
      status.execute();
    });
    return null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.args(context) != null && isFirst) {
      var arg = Get.args(context) as Map<String, dynamic>;
      id = arg['id'];
      isFirst = false;
      actionRefresh();
    }
  }
}
