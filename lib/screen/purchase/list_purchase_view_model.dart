import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/my_pagination.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/Purchase.dart';
import 'package:posku/screen/purchase/list_purchase_screen.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class ListPurchaseViewModel extends State<ListPurchaseScreen>
    with TickerProviderStateMixin, ChangeNotifier {

  String status;

  Animation animation;
  AnimationController animationController;
  int sliding = 0;
  bool isSearch = false;
  TabController tabController;
  final FocusNode searchFocusNode = FocusNode();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Map<String, String> searchData;
  GlobalKey<PaginationListState<Purchase>> keyGRSearch = GlobalKey();
  int lastOffsetSearch = -1;
  List<bool> isFirst = [false, false, false, false];
  Map<String, String> filterData = {'sortBy': 'date', 'sortType': 'desc'};
  List<GlobalKey<PaginationListState<Purchase>>> keyGR = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  List<int> lastOffset = [-1, -1, -1, -1];
  bool isFirstSearch = false;
  final TextEditingController searchTextController = TextEditingController();

  Future<Null> actionRefresh() async{
    if (isSearch) {
      lastOffsetSearch = 0;
      keyGRSearch?.currentState?.resetFetchPageData();
      return null;
    }
    lastOffset[sliding] = -1;
    keyGR[sliding]?.currentState?.resetFetchPageData();
    return null;
  }


  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }
  /*@override
  void dispose() {

    super.dispose();
  }*/

  @override
  void initState() {

    status = Get.arguments;

    tabController = new TabController(vsync: this, length: 4);
    tabController.addListener(() {
      setState(() {
        sliding = tabController.index;
      });
    });
    animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    animation = new CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );

    if(status != null){
      setState(() {
        switch (status) {
          case 'pending':
            sliding = 0;
            tabController.index = sliding;
            break;
          case 'received':
            sliding = 1;
            tabController.index = sliding;
            break;
          default:
            sliding = 0;
            tabController.index = sliding;
            break;
        }
        actionRefresh();
      });
    }

    super.initState();
  }

  FocusNode initSearch({FocusNode searchFocusNode, PurchaseState homeState}) {
    isSearch = true;
    debugPrint("initsearch ${searchFocusNode.hasListeners}");
    if (searchFocusNode.hasListeners == false) {
      searchFocusNode?.addListener(() async {
        if (!animationController.isAnimating) {
          animationController.forward();
        }
      });
    }
    return searchFocusNode;
  }

  FocusNode initFocus({PurchaseState homeState}) {
    FocusNode focusNode = FocusNode();
    focusNode.addListener(() async {
      isSearch = true;
      homeState.changeSearch(true);
      await Future.delayed(Duration(milliseconds: 100));
      searchFocusNode?.requestFocus();
    });
    return focusNode;
  }

  void cancelSearch({PurchaseState purchaseState, bool notify}) {
    isSearch = false;
    searchData = null;
    /*listSearch?.clear();
    listSearch = null;*/
    if (notify ?? true) purchaseState?.changeSearch(false);
    searchTextController.clear();
    searchFocusNode.unfocus();
    animationController.reverse();
  }

  void clearSearch() {
    searchTextController.clear();
  }

  String getSaleStatus({int customSliding}) {
    switch(customSliding ?? sliding) {
      case 1:
        return 'received';
      case 2:
        return 'partial';
      case 3:
        return 'returned';
      default:
        return 'pending';
    }
  }

  Future<List<Purchase>> pageFetch(int offset, int curSliding) async {
    if (!isSearch) {
      if (offset == lastOffset[curSliding]) return null;
      lastOffset[curSliding] = offset;
    } else {
      if (offset == -1) return null;
      lastOffsetSearch = offset;
    }
    List<Purchase> upcomingList;
    var params = {
      if (!isSearch)
        MyString.KEY_PURCHASE_STATUS: getSaleStatus(customSliding: curSliding),
      'offset': offset.toString(),
      'limit': '10',
    };
    params.addAll(filterData);
    if (searchData != null && searchData.isNotEmpty) {
      params.clear();
      params.addAll(searchData);
    }
    var status = await ApiClient.methodGet(ApiConfig.urlListPurchase,
        params: params, tagOrFlag: sliding, onBefore: (status) {
//      Get.back();
        }, onSuccess: (data, flag) {
          var baseResponse = BaseResponse.fromJson(data);
          var newListSB = baseResponse?.data?.listPurchase ?? [];
          upcomingList = newListSB;
        }, onFailed: (title, message) {
          Get.defaultDialog(title: title, content: Text(message));
        }, onError: (title, message) {
          Get.defaultDialog(title: title, content: Text(message));
        }, onAfter: (status) {
//      if (status == ResponseStatus.success)
//        MyPref.setRemember(isRemember, currentData);
        });
    status.execute();
    return upcomingList;
  }

  void onUpdate(String update) {}

  void onSubmit(String submit) {
    searchData?.clear();
    searchData = {
      'search': submit,
    };
    actionRefresh();
  }

  goToDetail(purchase) async {
    var result =
    await Get.toNamed(purchaseDetail, arguments: purchase.toJson());
    if (getArg('result', myArg: result) != null) {
      actionRefresh();
    }
  }
}