import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/empty_app_bar.dart';
import 'package:posku/helper/ios_search_bar.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/GoodReceived.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:timeago/timeago.dart' as timeago;

class GoodReceiveScreen extends StatefulWidget {
  @override
  _GoodReceiveScreenState createState() => _GoodReceiveScreenState();
}

class _GoodReceiveScreenState extends State<GoodReceiveScreen>
    with SingleTickerProviderStateMixin {
  int _sliding = 0;
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  Animation _animation;
  AnimationController _animationController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  bool isFirst = true;
  List<GoodReceived> listGoodReceived = [];

  @override
  void initState() {
    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });
//    WidgetsBinding.instance
//        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    _actionRefresh();
    super.initState();
  }

  void _cancelSearch() {
    _searchTextController.clear();
    _searchFocusNode.unfocus();
    _animationController.reverse();
  }

  void _clearSearch() {
    _searchTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
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
                      0: Container(child: Text('Mengirim')),
                      1: Container(child: Text('Diterima')),
                    },
                    groupValue: _sliding,
                    onValueChanged: (newValue) {
                      setState(() {
                        _sliding = newValue;
                      });
                    },
                  ),
                  trailing: CupertinoButton(
                    minSize: 16,
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {
                      _refreshIndicatorKey.currentState.show();
//                      _actionRefresh();
                    },
                    child: Icon(
                      Icons.filter_list,
                      size: 32,
                    ),
                  ),
                  largeTitle: IOSSearchBar(
                    controller: _searchTextController,
                    focusNode: _searchFocusNode,
                    animation: _animation,
                    onCancel: _cancelSearch,
                    onClear: _clearSearch,
                  ),
                ),
              ];
            },
            body: isFirst
                ? Center(
                    child: CupertinoActivityIndicator(),
                  )
                : RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: _actionRefresh,
                    child: listGoodReceived.length == 0
                        ? LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints viewportConstraints) {
                              return SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minHeight: viewportConstraints.maxHeight),
                                  child: Center(
                                    child: Text('Data Kosong'),
                                  ),
                                ),
                              );
                            },
                          )
                        : _body(),
                  ),
          ),
        ),
      ),
    );
  }

  Future<Null> _actionRefresh() async {
    var status = await ApiClient.methodGet(ApiConfig.urlListGoodReceived,
        onBefore: (status) {
//      Get.back();
    }, onSuccess: (data) {
      var baseResponse = BaseResponse.fromJson(data);
      listGoodReceived.clear();
      listGoodReceived.addAll(baseResponse.data.listGoodsReceived);
      listGoodReceived.sort((a, b) => b.createdAt.compareTo(a.createdAt));
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
      if (isFirst) isFirst = false;
    });

    return null;
  }

  Widget _body() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
      physics: ClampingScrollPhysics(),
//      controller: isFilter? null : _controller,
      itemBuilder: (c, i) => _listItem(listGoodReceived[i], i),
      itemCount: listGoodReceived.length,
    );
  }

  Widget _listItem(GoodReceived gr, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      elevation: 8,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${gr.namaProduk}',
                      style: TextStyle(
                        color: MyColor.mainRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('${gr.qtyDo} ${gr.uom}'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.av_timer,
                      size: 14,
                    ),
                    Text(
                      timeago.format(DateTime.tryParse('${gr.createdAt}'),
                          locale: 'id', allowFromNow: true),
                      style: TextStyle(
                        color: MyColor.mainRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('No SO'),
                    Text(
                      '${gr.noSo}',
                      style: TextStyle(
                        color: MyColor.mainRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('No DO'),
                    Text(
                      '${gr.noDo}',
                      style: TextStyle(
                        color: MyColor.mainRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
//            color: MyColor.txtField,
          ),
          InkWell(
            onTap: () {
              print('klik detail');
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Lihat Detail',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: FlatButton(
                    color: gr.statusPenerimaan == "received"
                        ? null
                        : MyColor.mainGreen,
                    onPressed: gr.statusPenerimaan == "received"
                        ? null
                        : () {
                            print('received');
                          },
                    child: gr.statusPenerimaan == "received"
                        ? null
                        : Text(
                            'Terima',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
