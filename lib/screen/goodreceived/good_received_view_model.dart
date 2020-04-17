import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/GoodReceived.dart';
import 'package:posku/screen/goodreceived/good_received_screen.dart';

abstract class GoodReceivedViewModel extends State<GoodReceiveScreen>
    with SingleTickerProviderStateMixin {
  int sliding = 0;
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  Animation animation;
  AnimationController animationController;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  List<bool> isFirst = [true, true];
  List<List<GoodReceived>> listGoodReceived = [[], []];

  @override
  void initState() {
    animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    animation = new CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    searchFocusNode.addListener(() {
      if (!animationController.isAnimating) {
        animationController.forward();
      }
    });
//    WidgetsBinding.instance
//        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    actionRefresh();
    super.initState();
  }

  void cancelSearch() {
    searchTextController.clear();
    searchFocusNode.unfocus();
    animationController.reverse();
  }

  void clearSearch() {
    searchTextController.clear();
  }

  Future<Null> actionRefresh() async {
    var params = {
      'goods_received_status': sliding == 0 ? 'delivering' : 'received',
    };
    var status = await ApiClient.methodGet(ApiConfig.urlListGoodReceived,
        params: params, tagOrFlag: sliding, onBefore: (status) {
//      Get.back();
    }, onSuccess: (data, flag) {
      if (isFirst[flag]) isFirst[flag] = false;
      var baseResponse = BaseResponse.fromJson(data);
      listGoodReceived[flag].clear();
      listGoodReceived[flag]
          .addAll(baseResponse?.data?.listGoodsReceived ?? []);
      listGoodReceived[flag].sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }, onFailed: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onError: (title, message) {
      Get.defaultDialog(title: title, content: Text(message));
    }, onAfter: (status) {
//      if (status == ResponseStatus.success)
//        MyPref.setRemember(isRemember, currentData);
    });
    setState(() {
      status.execute();
    });

    return null;
  }
}
