import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_cupertino_page_route.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/delivery.dart';
import 'package:posku/model/delivery_item.dart';
import 'package:posku/screen/delivery/detail_delivery_screen.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class DetailDeliveryViewModel extends State<DetailDeliveryScreen> {
  bool isFirst = true;
  Delivery delivery;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  List<DeliveryItem> deliveryItems;

  Future<Null> actionRefresh() async {
    await getDetailDelivery();
    return null;
  }

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

  actionCopy(String text) async {
    if (text != null) {
      Clipboard.setData(ClipboardData(text: text));
      Get.snackbar('Berhasil disalin', text);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.args(context) != null && isFirst) {
      var arg = Get.args(context) as Map<String, dynamic>;
      delivery = Delivery.fromJson(arg ?? {});
      actionRefresh();
      isFirst = false;
    }
    (ModalRoute.of(context) as CustomCupertinoPageRoute)?.resultPop =
        delivery?.toJson();
  }
}
