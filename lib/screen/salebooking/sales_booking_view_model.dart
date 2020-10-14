import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/helper/my_pagination.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/screen/home/home_screen.dart';
import 'package:posku/screen/salebooking/sales_booking_screen.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class SalesBookingViewModel extends State<SalesBookingScreen>
    with TickerProviderStateMixin, ChangeNotifier {
  int sliding = 0;
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  Animation animation;
  AnimationController animationController;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  List<bool> isFirst = [false, false, false];
  List<List<SalesBooking>> listSalesBooking = [[], [], []];
  List<SalesBooking> listSearch;
  Map<String, String> filterData = {'sortBy': 'date', 'sortType': 'desc'};
  bool isSearch = false;
  Map<String, String> searchData;
  TabController tabController;
  GlobalKey<PaginationListState<SalesBooking>> keyGRSearch = GlobalKey();
  List<GlobalKey<PaginationListState<SalesBooking>>> keyGR = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  List<int> lastOffset = [-1, -1, -1];
  int lastOffsetSearch = -1;

  @override
  void dispose() {
    searchTextController.dispose();
    tabController.dispose();
    super.dispose();
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

  void onUpdate(String update) {}

  void onSubmit(String submit) {
    searchData?.clear();
    searchData = {
      'search': submit,
    };
    actionRefresh();
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

  List<SalesBooking> listData() {
    if (isSearch) {
      return listSearch ?? [];
    } else {
      return listSalesBooking[sliding] ?? [];
    }
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

  actionClose(sb) async {
    var params = {
      MyString.KEY_ID_SALES: sb?.id,
    };
    var status = await ApiClient.methodPost(
      ApiConfig.urlCloseSalesBooking,
      {},
      params,
      onSuccess: (data, _) {
        setState(() {
          isFirst[2] = true;
          isFirst[1] = true;
          sliding = 2;
        });
        actionRefresh();
      },
      onFailed: (title, message) {
        var errorData = BaseResponse.fromJson(tryJsonDecode(message) ?? {});
        CustomDialog.showAlertDialog(Get.overlayContext,
            title: title,
            message: 'Kode error: ${errorData?.code}\n${errorData?.message}',
            leftAction: CustomDialog.customAction());
      },
      onError: (title, message) {
        CustomDialog.showAlertDialog(Get.overlayContext,
            title: title,
            message: message,
            leftAction: CustomDialog.customAction());
      },
    );
    status.execute();
  }

  goToDetail(sb) async {
    var result =
    await Get.toNamed(sbDetailScreen, arguments: sb.toJson());
    if (getArg('result', myArg: result) != null) {
      actionRefresh();
    }
  }
}
