import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/GoodReceived.dart';
import 'package:posku/screen/goodreceived/good_received_screen.dart';
import 'package:posku/screen/home/home_screen.dart';

abstract class GoodReceivedViewModel extends State<GoodReceiveScreen>
    with SingleTickerProviderStateMixin, ChangeNotifier {
  int sliding = 0;
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  Animation animation;
  AnimationController animationController;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  List<bool> isFirst = [true, true];
  List<List<GoodReceived>> listGoodReceived = [[], []];
  List<GoodReceived> listSearch;
  Map<String, String> filterData = {'date': 'desc'};
  bool isSearch = false;
  Map<String, String> searchData;

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

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
//    searchTextController.add
//    showSearch();
//    WidgetsBinding.instance
//        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    actionRefresh();
    super.initState();
  }

  void onUpdate(String update) {
  }

  void onSubmit(String submit) {
    searchData?.clear();
    searchData = {
      'search': submit,
    };
    refreshIndicatorKey.currentState.show();
  }

  FocusNode initSearch({FocusNode searchFocusNode, HomeState homeState}) {
    if (searchFocusNode.hasListeners == false) {
      searchFocusNode?.addListener(() async {
        if (!animationController.isAnimating) {
          animationController.forward();
        }
      });
    }
    return searchFocusNode;
  }

  FocusNode initFocus({HomeState homeState}) {
    FocusNode focusNode = FocusNode();
    focusNode.addListener(() async {
      isSearch = true;
      homeState.changeSearch(true);
      await Future.delayed(Duration(milliseconds: 100));
      searchFocusNode?.requestFocus();
    });
    return focusNode;
  }

  void cancelSearch({HomeState homeState, bool notify}) {
    isSearch = false;
    searchData = null;
    listSearch?.clear();
    listSearch = null;
    if (notify ?? true) homeState?.changeSearch(false);
    searchTextController.clear();
    searchFocusNode.unfocus();
    animationController.reverse();
  }

  void clearSearch() {
    searchTextController.clear();
  }

  List<GoodReceived> listData() {
    if (isSearch) {
      return listSearch ?? [];
    } else {
      return listGoodReceived[sliding] ?? [];
    }
  }

  Future<Null> actionRefresh() async {
    var params = {
      'goods_received_status': sliding == 0 ? 'delivering' : 'received',
    };
    params.addAll(filterData);
    if (searchData != null && searchData.isNotEmpty) {
      params.clear();
      params.addAll(searchData);
    }
    var status = await ApiClient.methodGet(ApiConfig.urlListGoodReceived,
        params: params, tagOrFlag: sliding, onBefore: (status) {
//      Get.back();
    }, onSuccess: (data, flag) {
      var baseResponse = BaseResponse.fromJson(data);
      var newListGR = baseResponse?.data?.listGoodsReceived ?? [];
      if (isSearch) {
        if (listSearch == null)
          listSearch = [];
        else
          listSearch?.clear();
        listSearch.addAll(newListGR);
      } else {
        if (isFirst[flag]) isFirst[flag] = false;
        listGoodReceived[flag].clear();
        listGoodReceived[flag].addAll(newListGR);
        listGoodReceived[flag]
            .sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
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
