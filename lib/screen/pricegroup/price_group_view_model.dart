import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/customer_group.dart';
import 'package:posku/screen/pricegroup/price_group_screen.dart';

abstract class PriceGroupViewModel extends State<PriceGroupScreen> {
  List<CustomerGroup> listCustomerGroup = [];
  bool isFirst = true;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> actionRefresh() async {
    var status = await ApiClient.methodGet(ApiConfig.urlListCustomerGroup,
        onBefore: (status) {
    }, onSuccess: (data, flag) {
      isFirst = false;
      var baseResponse = BaseResponse.fromJson(data);
      listCustomerGroup.clear();
      listCustomerGroup.addAll(baseResponse?.data?.customerGroups ?? []);
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
