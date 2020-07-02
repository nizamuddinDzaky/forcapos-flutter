import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/custom_cupertino_page_route.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/company.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/delivery.dart';
import 'package:posku/model/payment.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/model/sales_booking_item.dart';
import 'package:posku/model/warehouse.dart';
import 'package:posku/screen/salebooking/edit_sb_controller.dart';
import 'package:posku/screen/salebooking/sb_detail_screen.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class SBDetailViewModel extends State<SBDetailScreen> {
  bool isFirst = true;
  int sliding = 0;
  SalesBooking oldSB, newSb;
  List<SalesBookingItem> sbItems;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  Customer customer;
  Company supplier;
  Warehouse warehouse;
  List<Payment> listPayment;
  List<Delivery> listDelivery;

  SalesBooking get sb => newSb ?? oldSB;

  actionCopy(String text) async {
    if (text != null) {
      Clipboard.setData(ClipboardData(text: text));
      Get.snackbar('Berhasil disalin', text);
    }
  }

  Future<Null> actionRefresh() async {
    if (sliding == 0) {
      sbItems = null;
      customer = null;
      warehouse = null;
      supplier = null;
    } else if (sliding == 1) {
      listPayment = null;
    } else if (sliding == 2) {
      listDelivery = null;
    }
    setState(() {});
    return null;
  }

  Future<List<Payment>> getListPayment(String idSales) async {
    if (listPayment != null) return listPayment;
    var params = {
      MyString.KEY_ID_SALES_BOOKING: idSales,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlListPaymentBooking,
      params: params,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        listPayment = baseResponse?.data?.listPayment ?? [];
        listPayment.sort((a, b) => b.date.compareTo(a.date));
      },
      onAfter: (status) {
        setState(() {});
      },
    );
    status.execute();
    return null;
  }

  Future<List<Delivery>> getListDelivery(String idSales) async {
    if (listDelivery != null) return listDelivery;
    var params = {
      MyString.KEY_ID_SALES_BOOKING: idSales,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlListDeliveriesBooking,
      params: params,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        listDelivery = baseResponse?.data?.listDelivery ?? [];
        listDelivery.sort((a, b) => b.date.compareTo(a.date));
      },
      onAfter: (status) {
        setState(() {});
      },
    );
    status.execute();
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
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        newSb = baseResponse?.data?.salesBooking ?? sb;
//        sb.paid = newSb.paid;
//        sb.grandTotal = newSb.grandTotal;
        sbItems = baseResponse?.data?.salesBookingItems ?? [];
        EditSBController.to.sales = newSb;
        EditSBController.to.salesItem = sbItems;
      },
      onAfter: (status) {
        updateState();
      },
    );
    status.execute();
    return null;
  }

  updateState() {
    if (sbItems != null && customer != null && warehouse != null) {
      setState(() {});
    }
  }

  Future<Customer> getDetailCustomer(String idCustomer) async {
    if (idCustomer == '1') {
      customer = Customer(name: 'Eceran', id: '1');
      return customer;
    }
    if (customer != null) return customer;
    var params = {
      'id_customers': idCustomer,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailCustomer,
      params: params,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        customer = baseResponse?.data?.customer ?? Customer();
        EditSBController.to.customer = customer;
      },
      onAfter: (status) {
        updateState();
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
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        supplier = baseResponse?.data?.supplier ?? Company();
      },
      onAfter: (status) {
        updateState();
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
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        warehouse = baseResponse?.data?.warehouse ?? Warehouse();
        EditSBController.to.warehouse = warehouse;
      },
      onAfter: (status) {
        updateState();
      },
    );
    status.execute();
    return null;
  }

  goToDetailPayment(Payment payment) async {
    await Get.toNamed(
      detailPaymentScreen,
      arguments: payment.toJson(),
    );
  }

  goToAddPayment() async {
    var result = await Get.toNamed(
      addPaymentScreen,
      arguments: sb.toJson(),
    );
    if (result == 'newPayment') {
      sbItems = null;
      actionRefresh();
    }
  }

  goToEditPayment(int idx, {Payment payment}) async {
    if (idx == 0) {
      var result = await Get.toNamed(
        editPaymentScreen,
        arguments: {
          'payment': payment.toJson(),
        },
      );
      if (result == 'editPayment') {
        listPayment = null;
        actionRefresh();
      }
    }
  }

  goToAddDelivery() async {
    var result = await Get.toNamed(
      addDeliveryScreen,
      arguments: {
        'sale': sb,
        'customer': customer,
        'sbItems': sbItems,
      },
    );
    if (result == 'newDelivery') {
      actionRefresh();
    }
  }

  goToEditDelivery(Delivery delivery) async {
    var result = await Get.toNamed(
      editDeliveryScreen,
      arguments: {
        'sale': sb,
        'customer': customer,
        'delivery': delivery,
        'sbItems': sbItems,
      },
    );
    if (result == 'editDelivery') {
      listDelivery = null;
      actionRefresh();
    }
  }

  goToDetailDelivery(Delivery delivery) async {
    var result =
        await Get.toNamed(detailDeliveryScreen, arguments: delivery.toJson());
    if (result != null) {
      setState(() {});
    }
  }

  goToReturnDelivery(Delivery delivery) async {
    var result = await Get.toNamed(
      returnDeliveryScreen,
      arguments: {
        'sale': sb,
        'customer': customer,
        'delivery': delivery,
      },
    );
    if (result != null) {
      setState(() {});
    }
  }

  goToEditSales() async {
    var result = await Get.toNamed(
      editSalesBookingScreen,
      arguments: {},
    );
    if (result != null) {
      if (result == 'editSales') {
        sbItems = null;
        customer = null;
        warehouse = null;
        supplier = null;
        putArg(Get.arguments, 'result', 'editSales');
      }
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.arguments != null && isFirst) {
      var arg = Get.arguments as Map<String, dynamic>;
      oldSB = SalesBooking.fromJson(arg ?? {});
      getListDelivery(oldSB.id);
      isFirst = false;
    }
    (ModalRoute.of(context) as CustomCupertinoPageRoute)?.resultPop =
        Get.arguments;
  }

  @override
  void initState() {
    Get.put(EditSBController());
    super.initState();
  }
}
