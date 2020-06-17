import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/empty_app_bar.dart';
import 'package:posku/helper/ios_search_bar.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/screen/customer/customer_screen.dart';
import 'package:posku/screen/customergroup/customer_group_screen.dart';
import 'package:posku/screen/home/home_screen.dart';
import 'package:posku/screen/masterdata/master_data_controller.dart';
import 'package:posku/screen/pricegroup/price_group_screen.dart';
import 'package:posku/util/my_number.dart';
import 'package:provider/provider.dart';

class MasterDataScreen extends StatefulWidget {
  @override
  _MasterDataScreenState createState() => _MasterDataScreenState();
}

class _MasterDataScreenState extends State<MasterDataScreen>
    with SingleTickerProviderStateMixin, ChangeNotifier {
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  Animation animation;
  AnimationController animationController;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  int sliding = 0;
  bool isSearch = false;
  List<bool> isFirst = [true, true, true];
  List<String> listSearch;

  void cancelSearch({HomeState homeState, bool notify}) {}

  void onUpdate(String update) {}

  void onSubmit(String submit) {}

  void clearSearch() {
    searchTextController.clear();
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

  Future<Null> actionRefresh() async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlSyncToBK,
      {},
      {},
      firstAction: () {
        _showDialog();
      },
      onBefore: (status) {
        Get.back();
      },
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        var msg =
            'Jumlah data: ${MyNumber.toNumberId(baseResponse?.data?.totalCustomerData?.toDouble())}';
        Get.defaultDialog(title: 'Sinkronisasi Berhasil', content: Text(msg));
      },
      onFailed: (title, message) {
        var baseResponse = BaseResponse.fromJson(jsonDecode(message ?? '{}'));
        var msg = '${baseResponse?.code}: ${baseResponse?.message}';
        Get.defaultDialog(title: title, content: Text(msg));
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text(message ?? 'error'));
      },
      onAfter: (status) {},
    );
    setState(() {
      status.execute();
    });
    return null;
  }

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
//    actionRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeState>(
      builder: (context, homeState, _) {
        if (homeState.isBack) {
          homeState.isBack = false;
          cancelSearch(homeState: homeState, notify: false);
        }

        return CupertinoPageScaffold(
          child: Scaffold(
            appBar: EmptyAppBar(),
            body: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder: (ctx, innerBoxIsScrolled) {
                  return [
                    CupertinoSliverNavigationBar(
                      transitionBetweenRoutes: false,
                      heroTag: 'logoForcaPoS',
                      middle: CupertinoSlidingSegmentedControl(
                        children: {
                          0: Container(
                            child: Text(
                              'Pelanggan',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          1: Container(
                            child: Text(
                              'K. Pelanggan',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          2: Container(
                            child: Text(
                              'K. Harga',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        },
                        groupValue: sliding,
                        onValueChanged: (newValue) {
                          setState(() {
                            sliding = newValue;
                          });
                        },
                      ),
                      trailing: sliding != 1
                          ? CupertinoButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: _showMenu,
                              child: Icon(
                                Icons.more_vert,
                                size: 24,
                              ),
                            )
                          : CupertinoButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: () async {},
                              child: Icon(
                                Icons.filter_list,
                                size: 32,
                              ),
                            ),
                      largeTitle: IOSSearchBar(
                        animation: animationController,
                        controller: TextEditingController(),
                        focusNode: initFocus(homeState: homeState),
                      ),
                    ),
                  ];
                },
                body: _body(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _body() {
    switch (sliding) {
      case 1:
        return CustomerGroupScreen();
      case 2:
        return PriceGroupScreen();
      default:
        return CustomerScreen();
    }
  }

  void _showDialog() async {
    // flutter defined function
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Center(
          child: Container(
            width: 64,
            height: 64,
            //color: Colors.white,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: CupertinoActivityIndicator(),
          ),
        );
      },
    );
    print('selesai loading');
  }

  _showMenu() {
    final action = CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Filter Data"),
          onPressed: () {
            print("Action 1 is been clicked");
            Get.back();
          },
        ),
        if (sliding == 2)
          CupertinoActionSheetAction(
            child: Text("Tambah Kelompok Harga"),
            onPressed: () {
              print("Action 2 is been clicked");
              Get.back();
              Get.toNamed(addEditPGScreen).then((value) {
                print('cek value $value');
                if (value != null) {
                  MasterDataController.to?.isRefresh = true;
                  MasterDataController.to?.update();
                }
              });
            },
          ),
        if (sliding == 0)
        CupertinoActionSheetAction(
          child: Text("Sinkronisasi Data Pelanggan & BK"),
          onPressed: () {
            print("Action 2 is been clicked");
            Get.back();
            actionRefresh();
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Batal"),
        onPressed: () {
          Get.back();
        },
      ),
    );

    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Get.put(MasterDataScreen());
  }
}
