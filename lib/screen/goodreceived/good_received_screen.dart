import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/empty_app_bar.dart';
import 'package:posku/helper/ios_search_bar.dart';
import 'package:posku/model/GoodReceived.dart';
import 'package:posku/screen/goodreceived/good_received_view_model.dart';
import 'package:posku/screen/home/home_screen.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:provider/provider.dart';

class GoodReceiveScreen extends StatefulWidget {
  @override
  _GoodReceiveScreenState createState() => _GoodReceiveScreenState();
}

class _GoodReceiveScreenState extends GoodReceivedViewModel {
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
                    if (homeState.isSearch == false)
                      CupertinoSliverNavigationBar(
                        transitionBetweenRoutes: false,
                        heroTag: 'logoForcaPoS',
                        middle: CupertinoSlidingSegmentedControl(
                          children: {
                            0: Container(child: Text('Dikirim')),
                            1: Container(child: Text('Diterima')),
                          },
                          groupValue: sliding,
                          onValueChanged: (newValue) {
                            setState(() {
                              sliding = newValue;
                              if (isFirst[sliding]) actionRefresh();
                            });
                          },
                        ),
                        trailing: CupertinoButton(
                          minSize: 16,
                          padding: EdgeInsets.all(0.0),
                          onPressed: () async {
//                          homeState?.changeSearch(true);
//                            searchFocusNode.requestFocus();
                            filterData.addAll({'page': 'gr'});
                            var result = await Get.toNamed(
                              filterScreen,
                              arguments: filterData,
                            );
                            if (result != null &&
                                result as Map<String, String> != null) {
                              filterData = result as Map<String, String>;
                              refreshIndicatorKey.currentState.show();
                            }
                          },
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
                    if (homeState.isSearch == true)
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(left: 8),
                          child: CupertinoNavigationBar(
                            middle: IOSSearchBar(
                              controller: searchTextController,
                              focusNode: initSearch(
                                searchFocusNode: searchFocusNode,
                                homeState: homeState,),
                              animation: animation,
                              onCancel: () =>
                                  cancelSearch(homeState: homeState),
                              onClear: clearSearch,
                              onSubmit: onSubmit,
                              onUpdate: onUpdate,
                            ),
                          ),
                        ),
                      ),
                  ];
                },
                body: homeState.isSearch == true
                    ? _contentSearch()
                    : _contentBody(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _contentSearch() {
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: actionRefresh,
      child: (listSearch == null || listSearch.isEmpty)
          ? LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight),
                    child: Center(
                      child: Text(
                        listSearch == null
                            ? 'Mau cari apa nih?'
                            : 'Tidak menemukan hasil',
                      ),
                    ),
                  ),
                );
              },
            )
          : _body(),
    );
  }

  Widget _contentBody() {
    return isFirst[sliding]
        ? Center(
            child: CupertinoActivityIndicator(),
          )
        : RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: actionRefresh,
            child: listGoodReceived[sliding].length == 0
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
          );
  }

  Widget _body() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
      physics: ClampingScrollPhysics(),
//      controller: isFilter? null : _controller,
      itemBuilder: (c, i) => _listItem(listData()[i], i),
      itemCount: listData().length,
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
                    Text('${MyNumber.toNumberIdStr(gr.qtyDo)} ${gr.uom}'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.av_timer,
                      size: 14,
                    ),
                    Text(
                      strToDate(gr.createdAt),
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
            onTap: () async {
              var result =
                  await Get.toNamed(grDetailScreen, arguments: gr.toJson());
              if (result != null) {
                setState(() {
                  var newGr = GoodReceived.fromJson(result);
                  gr.statusPenerimaan = newGr.statusPenerimaan;
                });
              }
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
                        : () async {
                            var result = await Get.toNamed(grConfirmationScreen,
                                arguments: gr.toJson());
                            if (result != null) {
                              setState(() {
                                var newGr = GoodReceived.fromJson(result);
                                gr.statusPenerimaan = newGr.statusPenerimaan;
                              });
                            }
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
