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

class SalesBookingScreen extends StatefulWidget {
  @override
  _SalesBookingScreenState createState() => _SalesBookingScreenState();
}

class _SalesBookingScreenState extends SalesBookingViewModel {
  _showMenu(SalesBooking sb) {
    final action = CupertinoActionSheet(
      title: Text('Menu Penjualan'),
      message: sb.referenceNo == null ? null : Text(sb.referenceNo),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Rincian Penjualan"),
          onPressed: () {
            Get.back();
            goToDetail(sb);
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Selesaikan Penjualan"),
          onPressed: () {
            Get.back();
            actionClose(sb);
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
                            var old = getArg('result');
                            await Get.toNamed(addSalesBookingScreen);
                            if (old != getArg('result')) {
                              setState(() {
                                switch (getArg('status')) {
                                  case 'reserved':
                                    sliding = 1;
                                    break;
                                  case 'closed':
                                    sliding = 2;
                                    break;
                                  default:
                                    sliding = 0;
                                    break;
                                }
                                refreshIndicatorKey.currentState.show();
                              });
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
      child: InkWell(
        onTap: () async {
          if (sliding == 1) {
            _showMenu(sb);
            return;
          }
          await goToDetail(sb);
        },
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
                                    text: strToDate(sb.date),
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
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Dibuat oleh: ',
                            style: TextStyle(color: MyColor.txtField),
                          ),
                          Flexible(
                            child: Text(
                              '${sb.createdBy}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MyColor.txtField),
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
                    flex: 0,
                    child: Text(
                      '${MyNumber.toNumberRpStr(sb.grandTotal)}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: MyColor.txtField),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
