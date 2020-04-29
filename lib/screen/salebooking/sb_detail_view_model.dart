import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_cupertino_page_route.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/company.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/model/sales_booking_item.dart';
import 'package:posku/model/warehouse.dart';
import 'package:posku/screen/salebooking/sb_detail_screen.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class SBDetailViewModel extends State<SBDetailScreen> {
  bool isFirst = true;
//  String idSb;
  SalesBooking sb;
  SalesBooking newSb;
  List<SalesBookingItem> sbItems;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  Customer customer;
  Company supplier;
  Warehouse warehouse;

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
    sbItems = null;
    customer = null;
    warehouse = null;
    supplier = null;
    setState(() {});
    return null;
  }

  Future<List<SalesBookingItem>> getSalesBookingItem(String idSales) async {
    if (sbItems != null) return sbItems;
    var params = {
      MyString.KEY_ID_SALES_BOOKING: idSales,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailSalesBooking,
      params: params,
      onBefore: (status) {
        print('onbefore');
      },
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        sb = baseResponse.data.salesBooking ?? sb;
        sbItems = baseResponse.data.salesBookingItems ?? [];
        updateState();
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
    return null;
  }

  updateState() {
    if (sbItems != null && customer != null && warehouse != null && supplier != null) {
      setState(() {});
    }
  }

  Future<Customer> getDetailCustomer(String idCustomer) async {
    if (customer != null) return customer;
    var params = {
      'id_customers': idCustomer,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailCustomer,
      params: params,
      onBefore: (status) {
        print('onbefore');
      },
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        customer = baseResponse.data.customer ?? Customer();
        updateState();
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
    return null;
  }

  Future<Company> getDetailSupplier(String idCompany) async {
    if (supplier != null) return supplier;
    var params = {
      MyString.KEY_ID_SUPPLIER: idCompany,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailSupplier,
      params: params,
      onBefore: (status) {
        print('onbefore');
      },
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        supplier = baseResponse.data.supplier ?? Company();
        updateState();
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
    return null;
  }

  Future<Warehouse> getDetailWarehouse(String idWarehouse) async {
    if (warehouse != null) return warehouse;
    var params = {
      MyString.KEY_ID_WAREHOUSE: idWarehouse,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailWarehouse,
      params: params,
      onBefore: (status) {
        print('onbefore');
      },
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        warehouse = baseResponse.data.warehouse ?? Warehouse();
        updateState();
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
//      idSb = sb.id;
//      actionGetDetailSB();
      isFirst = false;
    }
    (ModalRoute.of(context) as CustomCupertinoPageRoute)?.resultPop =
        newSb?.toJson();
  }
}
