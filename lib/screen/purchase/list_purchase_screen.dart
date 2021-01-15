import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/helper/empty_app_bar.dart';
import 'package:posku/helper/ios_search_bar.dart';
import 'package:posku/helper/my_pagination.dart';
import 'package:posku/model/Purchase.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/screen/purchase/list_purchase_view_model.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/my_pref.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:provider/provider.dart';

class PurchaseState extends ChangeNotifier {
  bool isBack = false;
  bool _isSearch = false;
  int _roleId;

  bool get isSearch => _isSearch;

  int get roleId => _roleId;

//  int get roleId => MyString.ROLE_SUPER_ADMIN;
//  int get roleId => MyString.ROLE_WAREHOUSE_ADMIN;
//  int get roleId => MyString.ROLE_CASHIER;

  void changeRole(int newRole, {bool isNotify}) {
    _roleId = newRole;
    if (isNotify == true) notifyListeners();
  }

  void changeSearch(bool isSearch, {Function action}) {
    this._isSearch = isSearch;
    if (action != null) action();
    notifyListeners();
  }

  void popBack() {
    isBack = true;
    _isSearch = false;
    notifyListeners();
  }
}

class ListPurchaseScreen extends StatefulWidget {
  @override
  _ListPurchaseScreenState createState() => _ListPurchaseScreenState();
}

class _ListPurchaseScreenState extends ListPurchaseViewModel {
  /*PurchaseState purchaseState;*/

  @override
  Widget build(BuildContext context) {
    /*debugPrint("asdds => ${purchaseState.isBack}");*/
    /*if (purchaseState.isBack) {
      purchaseState.isBack = false;
      cancelSearch(purchaseState: purchaseState, notify: false);
    }*/
    // TODO: implement build

    Future<bool> _willPopCallback(PurchaseState homeState) async {
      if (homeState.isSearch == true) {
        homeState.popBack();
        return false;
      }
      return true;
    }

    return ChangeNotifierProvider(
      create: (_) => PurchaseState()..changeRole(MyPref.getRole()),
        child: Consumer<PurchaseState>(
            builder: (context, homeState, _) {
              if (homeState.isBack) {
                homeState.isBack = false;
                cancelSearch(purchaseState: homeState, notify: false);
              }
              return WillPopScope(
                onWillPop: () => _willPopCallback(homeState),
                child: CupertinoPageScaffold(
                  child: Scaffold(
                    appBar: EmptyAppBar(),
                    body: SafeArea(
                        child: NestedScrollView(
                          headerSliverBuilder: (ctx, innerBoxIsScrolled) {
                            return [
                              if(homeState.isSearch == false)
                                CupertinoSliverNavigationBar(
                                  leading: CupertinoButton(
                                    minSize: 0,
                                    padding: EdgeInsets.all(0.0),
                                    onPressed: () async {
                                      Get.back();
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 24,
                                    ),
                                  ),
                                  transitionBetweenRoutes: false,
                                  heroTag: 'logoForcaPoS',
                                  middle: CupertinoSlidingSegmentedControl(
                                    children: {
                                      0: Flexible(
                                          child: Text(
                                            'Menunggu',
                                            style: TextStyle(fontSize: 16),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )
                                      ),
                                      1: Flexible(
                                          child: Text(
                                            'Diterima',
                                            style: TextStyle(fontSize: 16),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )
                                      ),
                                      2: Flexible(
                                          child: Text(
                                            'Sebagian',
                                            style: TextStyle(fontSize: 16),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )
                                      ),
                                      3: Flexible(
                                          child: Text(
                                            'Dikembalikan',
                                            style: TextStyle(fontSize: 16),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )
                                      ),
                                    },
                                    groupValue: sliding,
                                    onValueChanged: (newValue) {
                                      setState(() {
                                        sliding = newValue;
                                        tabController.index = sliding;
                                      });
                                    },
                                  ),
                                  trailing: CupertinoButton(
                                    minSize: 16,
                                    padding: EdgeInsets.all(0.0),
                                    onPressed: _showOption,
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 24,
                                    ),
                                  ),
                                  largeTitle: IOSSearchBar(
                                    animation: animationController,
                                    controller: TextEditingController(),
                                    focusNode: initFocus(homeState: homeState),
                                  ),
                                ),
                              if(homeState.isSearch == true)
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
                                            cancelSearch(purchaseState: homeState),
                                        onClear: clearSearch,
                                        onSubmit: onSubmit,
                                        onUpdate: onUpdate,
                                      ),
                                    ),
                                  ),
                                ),
                            ];
                          },
                          body: DefaultTabController(
                            initialIndex: sliding,
                            length: 4,
                            child: homeState.isSearch == true
                                ? _contentSearch()
                                : _contentBody(),
                          ),
                        )
                    ),
                  ),
                ),
              );
            }
        )
    );
    /*return ;*/
  }

  Widget _contentBody() {
    return Container(
      color: Color(0xffE9E9E9),
      child: _body(),
    );
  }

  Widget _contentSearch() {
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: actionRefresh,
      child: PaginationList<Purchase>(
        key: keyGRSearch,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, Purchase salesBooking) {
          return _listItem(salesBooking);
        },
        lastOffset: lastOffsetSearch,
        sliding: 0,
        isSearch: isSearch,
        pageFetch: pageFetch,
        initialData: [],
        onLoading: Center(child: CupertinoActivityIndicator()),
        onPageLoading: Center(child: CircularProgressIndicator()),
        onError: (_) => _refreshEmpty(text: 'Terjadi Kesalahan Akses'),
        onEmpty: _refreshEmpty(),
      ),
    );
  }

  Widget _body() {
    if (sliding == 0) {
      lastOffset[1] = -1;
      lastOffset[2] = -1;
      lastOffset[3] = -1;
    }
    if (sliding == 1) {
      lastOffset[0] = -1;
      lastOffset[2] = -1;
      lastOffset[3] = -1;
    }

    if(sliding == 2){
      lastOffset[0] = -1;
      lastOffset[1] = -1;
      lastOffset[3] = -1;
    }
    lastOffset[0] = -1;
    lastOffset[1] = -1;
    lastOffset[2] = -1;
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        RefreshIndicator(
          onRefresh: actionRefresh,
          child: PaginationList<Purchase>(
            padding: EdgeInsets.symmetric(vertical: 4),
            key: keyGR[0],
            shrinkWrap: true,
            itemBuilder: (BuildContext context, Purchase purchase) {
              return _listItem(purchase);
            },
            lastOffset: lastOffset[0],
            sliding: 0,
            pageFetch: pageFetch,
            initialData: [],
            onLoading: Center(child: CupertinoActivityIndicator()),
            onPageLoading: Center(child: CircularProgressIndicator()),
            onError: (_) => _refreshEmpty(text: 'Terjadi Kesalahan Akses'),
            onEmpty: _refreshEmpty(),
          ),
        ),
        RefreshIndicator(
          onRefresh: actionRefresh,
          child: PaginationList<Purchase>(
            padding: EdgeInsets.symmetric(vertical: 4),
            key: keyGR[1],
            shrinkWrap: true,
            itemBuilder: (BuildContext context, Purchase purchase) {
              return _listItem(purchase);
            },
            lastOffset: lastOffset[1],
            sliding: 1,
            pageFetch: pageFetch,
            initialData: [],
            onLoading: Center(child: CupertinoActivityIndicator()),
            onPageLoading: Center(child: CircularProgressIndicator()),
            onError: (_) => _refreshEmpty(text: 'Terjadi Kesalahan Akses'),
            onEmpty: _refreshEmpty(),
          ),
        ),
        RefreshIndicator(
          onRefresh: actionRefresh,
          child: PaginationList<Purchase>(
            padding: EdgeInsets.symmetric(vertical: 4),
            key: keyGR[2],
            shrinkWrap: true,
            itemBuilder: (BuildContext context, Purchase purchase) {
              return _listItem(purchase);
            },
            lastOffset: lastOffset[2],
            sliding: 2,
            pageFetch: pageFetch,
            initialData: [],
            onLoading: Center(child: CupertinoActivityIndicator()),
            onPageLoading: Center(child: CircularProgressIndicator()),
            onError: (_) => _refreshEmpty(text: 'Terjadi Kesalahan Akses'),
            onEmpty: _refreshEmpty(),
          ),
        ),
        RefreshIndicator(
          onRefresh: actionRefresh,
          child: PaginationList<Purchase>(
            padding: EdgeInsets.symmetric(vertical: 4),
            key: keyGR[3],
            shrinkWrap: true,
            itemBuilder: (BuildContext context, Purchase purchase) {
              return _listItem(purchase);
            },
            lastOffset: lastOffset[3],
            sliding: 3,
            pageFetch: pageFetch,
            initialData: [],
            onLoading: Center(child: CupertinoActivityIndicator()),
            onPageLoading: Center(child: CircularProgressIndicator()),
            onError: (_) => _refreshEmpty(text: 'Terjadi Kesalahan Akses'),
            onEmpty: _refreshEmpty(),
          ),
        ),
      ],
    );
  }

  Widget _refreshEmpty({String text}) {
    return RefreshIndicator(
      onRefresh: actionRefresh,
      child: LayoutBuilder(
        builder: (BuildContext context,
            BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/female_forca.png'),
                    SizedBox(height: 16),
                    Text(text ?? 'Belum ada transaksi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    SizedBox(height: 16),
                    Text('Tarik ke bawah untuk memuat ulang'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _listItem(Purchase purchase) {
    var purchaseStyle = purchaseStatus(purchase.status);
    var paymentStyle = paymentStatus(purchase.paymentStatus);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      elevation: 0,
      child: InkWell(
        onTap: () async {
          /*_showMenu(purchase);*/
          goToDetail(purchase);
          /*if (sliding == 1) {
            _showMenu(sb);
            return;
          }
          await goToDetail(sb);*/
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
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '${purchase.referenceNo}',
                              style: TextStyle(
                                fontSize: 16,
                                color: MyColor.blueDio,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              strToDate(purchase.date),
                              style: TextStyle(
                                  fontSize: 13,
                                  color: MyColor.txtField,
                                  fontStyle: FontStyle.normal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            /*Text(
                              '${sb.customerId == '1' ? 'Eceran' : sb.customer}',
                              style: TextStyle(
                                color: MyColor.txtField,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    // Expanded(
                    //   flex: 2,
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: <Widget>[
                    //       Icon(
                    //         Icons.av_timer,
                    //         size: 14,
                    //       ),
                    //       Expanded(
                    //         child: RichText(
                    //           textAlign: TextAlign.left,
                    //           softWrap: true,
                    //           text: TextSpan(children: <TextSpan>[
                    //             TextSpan(
                    //                 text: strToDate(sb.date),
                    //                 style: TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: 12,
                    //                     fontWeight: FontWeight.normal)),
                    //           ]),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                      Text('Status Pembelian'),
                      Text(
                        '${purchaseStyle[0]}',
                        style: TextStyle(
                          color: purchaseStyle[1],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Status Pengiriman'),
                      Text(
                        '${paymentStyle[0]}',
                        style: TextStyle(
                          color: paymentStyle[1],
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
                            'Total: ',
                            style: TextStyle(color: MyColor.txtField),
                          ),
                          Flexible(
                            child: Text(
                              '${MyNumber.toNumberRpStr(purchase.grandTotal)}',
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

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showOption() {
    final action = CupertinoActionSheet(
      actions: <Widget>[
        /*CupertinoActionSheetAction(
          child: Text("Filter Data"),
          onPressed: () {
            Get.back();
          },
        ),*/
        CupertinoActionSheetAction(
          child: Text("Tambah Pembelian"),
          onPressed: () {
            Get.back();
            var old = getArg('result');
            Get.toNamed(addPurchase).then((value) => {
              debugPrint("value $value")
            });

            /*if (old != getArg('result')) {
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
            }*/
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

  _showMenu(Purchase purchase) {
    final action = CupertinoActionSheet(
      title: Text('Menu Pembelian'),
      message: purchase.referenceNo == null ? null : Text(purchase.referenceNo),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Rincian Pembelian"),
          onPressed: () {
            Get.back();
            goToDetail(purchase);
            /**/
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Tutup Penjualan"),
          onPressed: () {
            Get.back();
            /*actionClose(sb);*/
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

}