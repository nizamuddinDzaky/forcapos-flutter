import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/customer_group.dart';
import 'package:posku/screen/customergroup/customer_group_screen.dart';
import 'package:posku/screen/masterdata/master_data_controller.dart';

abstract class CustomerGroupViewModel extends State<CustomerGroupScreen> {
  List<CustomerGroup> listCustomerGroup = [];
  bool isFirst = true;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> actionRefresh() async {
    var status = await ApiClient.methodGet(ApiConfig.urlListCustomerGroup,
        onBefore: (status) {}, onSuccess: (data, flag) {
      isFirst = false;
      var baseResponse = BaseResponse.fromJson(data);
      listCustomerGroup.clear();
      listCustomerGroup.addAll(baseResponse?.data?.customerGroups ?? []);
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {});
    setState(() {
      status.execute();
    });
    return null;
  }

  goToAddCustomerToCG(CustomerGroup cg) async {
    await Get.toNamed(
      addCustomerToCGScreen,
      arguments: {
        'customer_group': cg.toJson(),
      },
    );
  }

  goToEditCustomerGroup(CustomerGroup cg) async {
    var result = await Get.toNamed(
      addEditCGScreen,
      arguments: {
        'customer_group': cg.toJson(),
      },
    );
    if (result != null) {
      actionRefresh();
    }
  }

  @override
  void initState() {
    actionRefresh();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Get.put(MasterDataController());
  }
}
