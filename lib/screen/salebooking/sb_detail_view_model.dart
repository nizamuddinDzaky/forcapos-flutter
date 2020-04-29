import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:posku/helper/custom_cupertino_page_route.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/model/sales_booking_item.dart';
import 'package:posku/screen/salebooking/sb_detail_screen.dart';

abstract class SBDetailViewModel extends State<SBDetailScreen> {
  bool isFirst = true;
  String idGr;
  SalesBooking sb;
  SalesBooking newSb;
  List<SalesBookingItem> sbItems = [];
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  actionCopy(String text) async {
    if (text != null) {
      Clipboard.setData(ClipboardData(text: text));
      Get.snackbar('Berhasil disalin', text);
      /*CustomDialog.showAlertDialog(
        context,
        title: 'Berhasil disalin',
        message: text,
      );*/
    }
  }

  Future<Null> actionRefresh() async {
    return null;
  }

  actionGetDetailSB() async {
    /*
    var params = {
      MyString.KEY_ID_GOODS_RECEIVED: idGr,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailGoodReceived,
      params: params,
      onBefore: (status) {
        print('onbefore');
      },
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        setState(() {
//          sb = baseResponse.data.goodReceived;
//          sbItems = baseResponse.data.goodReceivedItems;
        });
        print('onsuccess');
      },
      onFailed: (title, message) {
        print('onfailed');
      },
      onError: (title, message) {
        print('onerror');
      },
      onAfter: (status) {
        print('onafter');
      },
    );
    status.execute();
     */
    sbItems = [
      for (int i = 0; i < 3; i++)
      SalesBookingItem(
        productName: 'Semen',
        productUnitCode: 'SAK',
        realUnitPrice: '45000',
        quantity: '200',
        unitPrice: '42000',
      ),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.args(context) != null && isFirst) {
      var arg = Get.args(context) as Map<String, dynamic>;
      sb = SalesBooking.fromJson(arg ?? {});
      idGr = sb.id;
      actionGetDetailSB();
      isFirst = false;
    }
    (ModalRoute.of(context) as CustomCupertinoPageRoute)?.resultPop =
        newSb?.toJson();
  }
}
