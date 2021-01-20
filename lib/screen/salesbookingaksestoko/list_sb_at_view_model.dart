import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/my_pagination.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/Purchase.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_string.dart';

import 'list_sb_at_screen.dart';

abstract class ListSbAtViewModel extends State<ListSbAtScreen>
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
  GlobalKey<PaginationListState<SalesBooking>> keyGRSearch = GlobalKey();
  int lastOffsetSearch = -1;
  List<bool> isFirst = [false, false, false];
  Map<String, String> filterData = {'sortBy': 'date', 'sortType': 'desc'};
  List<GlobalKey<PaginationListState<SalesBooking>>> keyGR = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  List<int> lastOffset = [-1, -1, -1];
  bool isFirstSearch = false;
  final TextEditingController searchTextController = TextEditingController();


  FocusNode initSearch({FocusNode searchFocusNode, SbAtState homeState}) {
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

  FocusNode initFocus({SbAtState homeState}) {
    FocusNode focusNode = FocusNode();
    focusNode.addListener(() async {
      isSearch = true;
      homeState.changeSearch(true);
      await Future.delayed(Duration(milliseconds: 100));
      searchFocusNode?.requestFocus();
    });
    return focusNode;
  }

  void cancelSearch({SbAtState purchaseState, bool notify}) {
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
        return 'reserved';
      case 2:
        return 'closed';
      default:
        return 'pending';
    }
  }

  Future<List<SalesBooking>> pageFetch(int offset, int curSliding) async {
    if (!isSearch) {
      if (offset == lastOffset[curSliding]) return null;
      lastOffset[curSliding] = offset;
    } else {
      if (offset == -1) return null;
      lastOffsetSearch = offset;
    }
    List<SalesBooking> upcomingList;
    var params = {
      if (!isSearch)
        MyString.KEY_SALE_STATUS: getSaleStatus(customSliding: curSliding),
      'offset': offset.toString(),
      'limit': '10',
      'aksestoko' : 'aksestoko'
    };
    params.addAll(filterData);
    if (searchData != null && searchData.isNotEmpty) {
      params.clear();
      params.addAll(searchData);
    }
    var status = await ApiClient.methodGet(ApiConfig.urlListSalesBooking,
        params: params, tagOrFlag: sliding, onBefore: (status) {
//      Get.back();
        }, onSuccess: (data, flag) {
          var baseResponse = BaseResponse.fromJson(data);
          var newListSB = baseResponse?.data?.listSalesBooking ?? [];
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

  Future<Null> actionRefresh() async {
    if (isSearch) {
      lastOffsetSearch = 0;
      keyGRSearch?.currentState?.resetFetchPageData();
      return null;
    }
    lastOffset[sliding] = -1;
    keyGR[sliding]?.currentState?.resetFetchPageData();
    return null;
  }

  goToDetail(sb) async {
    var result =
    await Get.toNamed(sbDetailScreen, arguments: sb.toJson());
    if (getArg('result', myArg: result) != null) {
      actionRefresh();
    }
  }

  @override
  void initState() {
    tabController = new TabController(vsync: this, length: 3);
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
    super.initState();
  }
}