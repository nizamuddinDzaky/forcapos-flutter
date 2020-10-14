import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/my_pagination.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/GoodReceived.dart';
import 'package:posku/screen/goodreceived/good_received_screen.dart';
import 'package:posku/screen/home/home_screen.dart';

abstract class GoodReceivedViewModel extends State<GoodReceiveScreen>
    with TickerProviderStateMixin, ChangeNotifier {
  int sliding = 0;
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  Animation animation;
  AnimationController animationController;

  List<bool> isFirst = [false, false];
  List<List<GoodReceived>> listGoodReceived = [[], []];
  List<GoodReceived> listSearch;
  Map<String, String> filterData = {'date': 'desc'};
  bool isSearch = false;
  Map<String, String> searchData;
  TabController tabController;
  GlobalKey<PaginationListState<GoodReceived>> keyGRSearch = GlobalKey();
  List<GlobalKey<PaginationListState<GoodReceived>>> keyGR = [
    GlobalKey(),
    GlobalKey(),
  ];
  List<int> lastOffset = [-1, -1];
  int lastOffsetSearch = -1;

  @override
  void dispose() {
    searchTextController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    tabController = new TabController(vsync: this, length: 2);
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

  void onUpdate(String update) {
  }

  void onSubmit(String submit) {
    searchData?.clear();
    searchData = {
      'search': submit,
    };
    print('actionRefresh(); ');
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

  List<GoodReceived> listData() {
    if (isSearch) {
      return listSearch ?? [];
    } else {
      return listGoodReceived[sliding] ?? [];
    }
  }

  Future<List<GoodReceived>> pageFetch(int offset, int curSliding) async {
    if (!isSearch) {
      if (offset == lastOffset[curSliding]) return null;
      lastOffset[curSliding] = offset;
    } else {
      if (offset == -1) return null;
      lastOffsetSearch = offset;
    }
    debugPrint('cek offset $offset');
    List<GoodReceived> upcomingList;
    var params = {
      if (!isSearch)
        'goods_received_status': curSliding == 0 ? 'delivering' : 'received',
      'offset': offset.toString(),
      'limit': '10',
    };
    params.addAll(filterData);
    debugPrint('filterdata $filterData}');
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
      upcomingList = newListGR;
    },
        onFailed: (title, message) {},
        onError: (title, message) {},
        onAfter: (status) {});
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
}
