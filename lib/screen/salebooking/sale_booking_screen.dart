import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/empty_app_bar.dart';
import 'package:posku/helper/ios_search_bar.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/screen/home/home_screen.dart';
import 'package:posku/screen/salebooking/sales_booking_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeAGo;

class SalesBookingScreen extends StatefulWidget {
  @override
  _SalesBookingScreenState createState() => _SalesBookingScreenState();
}

class _SalesBookingScreenState extends SalesBookingViewModel {
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
                        leading: CupertinoButton(
                          minSize: 0,
                          padding: EdgeInsets.all(0.0),
                          onPressed: () async {
                            var result = await Get.toNamed(addSalesBookingScreen);
                            if (result == 'newSalesBooking') {
                              setState(() {});
                            }
                          },
                          child: Icon(
                            Icons.add,
                            size: 24,
                          ),
                        ),
                        transitionBetweenRoutes: false,
                        heroTag: 'logoForcaPoS',
                        middle: CupertinoSlidingSegmentedControl(
                          children: {
                            0: Container(child: Text('Menunggu')),
                            1: Container(child: Text('Dipesan')),
                            2: Container(child: Text('Selesai')),
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
                            filterData.addAll({'page': 'sb'});
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
                                homeState: homeState,
                              ),
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
            child: listSalesBooking[sliding].length == 0
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

  Widget _listItem(SalesBooking sb, int index) {
    var paymentStyle = paymentStatus(sb.paymentStatus);
    var deliveryStyle = deliveryStatus(sb.deliveryStatus);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      elevation: 8,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: MyColor.blueDio,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Center(
                      child: Text('PoS',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${sb.referenceNo}',
                            style: TextStyle(
                              color: MyColor.blueDio,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${sb.customerId == '1' ? 'Eceran' : sb.customer}',
                            style: TextStyle(
                              color: MyColor.txtField,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.av_timer,
                          size: 14,
                        ),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.left,
                            softWrap: true,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: timeAGo.format(
                                      DateTime.tryParse('${sb.createdAt}') ??
                                          DateTime.now(),
                                      locale: 'id',
                                      allowFromNow: true),
                                  style: TextStyle(
                                      color: MyColor.txtField,
                                      fontWeight: FontWeight.bold)),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                    Text('Status Pembayaran'),
                    Text(
                      '${paymentStyle[0]}',
                      style: TextStyle(
                        color: paymentStyle[1],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('Status Pengiriman'),
                    Text(
                      '${deliveryStyle[0]}',
                      style: TextStyle(
                        color: deliveryStyle[1],
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
                  await Get.toNamed(sbDetailScreen, arguments: sb.toJson());
              if (result != null) {
                setState(() {
                  var newGr = SalesBooking.fromJson(result);
                  sb.saleStatus = newGr.saleStatus;
                });
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Dibuat oleh: ',
                        style: TextStyle(color: MyColor.txtField),
                      ),
                      Text(
                        '${sb.createdBy}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColor.txtField),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '${MyNumber.toNumberRpStr(sb.grandTotal)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: MyColor.txtField),
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
