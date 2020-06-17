import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/price_group.dart';
import 'package:posku/screen/masterdata/master_data_controller.dart';
import 'package:posku/screen/pricegroup/price_group_screen.dart';

abstract class PriceGroupViewModel extends State<PriceGroupScreen> {
  List<PriceGroup> listPriceGroup = [];
  bool isFirst = true;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> actionRefresh() async {
    var status = await ApiClient.methodGet(ApiConfig.urlListPriceGroup,
        onBefore: (status) {
    }, onSuccess: (data, flag) {
      isFirst = false;
      var baseResponse = BaseResponse.fromJson(data);
      listPriceGroup.clear();
      listPriceGroup.addAll(baseResponse?.data?.priceGroups ?? []);
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Get.put(MasterDataController());
  }
}
