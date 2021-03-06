import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/product.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/model/warehouse.dart';
import 'package:posku/util/my_util.dart';

class SalesBookingController extends GetController {
  static SalesBookingController get to => Get.find();

  DateTime currentDate = DateTime.now();
  List<Product> cartList;
  List<Product> listProducts;
  List<Product> listSearch;
  Warehouse currentWarehouse;
  List<Warehouse> listWarehouse = [];
  Customer currentCustomer;
  List<Customer> listCustomer = [];
  bool isFirst = true;
  SalesBooking sales;
  bool isAddDelivery = false;

  void qtyMinus(Product p) {
    var newQty = p.minOrder.toDouble() - 1;
    if (newQty < 1) newQty = 1;
    p.minOrder = newQty.toString();
    refresh();
  }

  void qtyPlus(Product p) {
    var newQty = p.minOrder.toDouble() + 1;
    p.minOrder = newQty.toString();
    refresh();
  }

  void qtyCustom(Product p, String newValue, {bool isRefresh = true}) {
    var newQty = newValue.toDoubleID();
    if (newQty < 1) {
      newQty = 1;
    }
    p.minOrder = newQty.toString();
    if (isRefresh) refresh();
  }

  void qtyEdit(String newValue, TextEditingController qtyController) {
    if (newValue.isEmpty) return;
    var newQty = newValue.toDoubleID();
    if (newQty < 1) {
      newQty = 1;
      lastCursorEditText(qtyController, newQty);
    }
  }

  void refresh() {
    update();
  }

  String getTotal() {
    var total = 0.0;
    cartList?.forEach((element) {
      total += element.minOrder.toDouble() * element.price.toDouble();
      total -= element.minOrder.toDouble() * element.discount.toDouble();
    });
    total -= sales?.orderDiscount?.toDouble() ?? 0.0;
    total += sales?.shipping?.toDouble() ?? 0.0;
    return total.toString().toRp();
  }

  actionSearch(String txtSearch) async {
    if (txtSearch == null || txtSearch.length < 3) {
      listSearch?.clear();
      listSearch = null;
    } else {
      listSearch = [];
      listSearch.addAll(listProducts?.where((element) =>
          element.name.toLowerCase().contains(txtSearch.toLowerCase())));
    }
    refresh();
  }

  cancelSearch() {
    listSearch?.clear();
    listSearch = null;
    refresh();
  }

  void deleteFromCart(Product p) {
    p.minOrder = null;
    cartList?.remove(p);
    refresh();
    Get.back();
  }

  void addToCart(Product p, {double qty = 1, double customQty}) {
    if (cartList == null) cartList = [];
    var order = p.minOrder.toDouble();
    p.minOrder = customQty?.toString() ?? (order + qty).toString();
    if (!cartList.contains(p)) cartList.add(p);
    refresh();
  }

  List<Product> getListProducts() {
    if (isFirst) {
      actionGetProduct();
    }
    return listSearch ?? listProducts;
  }

  void setDate(DateTime newDateTime) {
    currentDate = newDateTime ?? currentDate;
    refresh();
  }

  actionGetWarehouse() async {
    if (listWarehouse.isNotEmpty) return;

    var status = await ApiClient.methodGet(
      ApiConfig.urlListWarehouse,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        listWarehouse.addAll(baseResponse?.data?.listWarehouses ?? []);
      },
    );
    status.execute();
  }

  actionGetCustomer() async {
    if (listCustomer.isNotEmpty) return;

    var status = await ApiClient.methodGet(
      ApiConfig.urlListCustomer,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        listCustomer.addAll(baseResponse?.data?.listCustomers ?? []);
      },
    );
    status.execute();
  }

  actionGetProduct() async {
    if (listProducts?.isNotEmpty ?? false) return;

    var status = await ApiClient.methodGet(
      ApiConfig.urlListProduct,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        if (listProducts == null) listProducts = [];
        listProducts.addAll(baseResponse?.data?.listProducts ?? []);
        isFirst = false;
        refresh();
      },
    );
    status.execute();
  }

  void showWarehousePicker(buildContext) {
    DataPicker.showDatePicker(
      buildContext,
      locale: 'id',
      datas: listWarehouse,
      title: 'Pilih Gudang',
      onConfirm: (data) {
        currentWarehouse = data;
        refresh();
      },
    );
  }

  void showCustomerPicker(buildContext) {
    DataPicker.showDatePicker(
      buildContext,
      locale: 'id',
      datas: listCustomer,
      title: 'Pilih Pelanggan',
      onConfirm: (data) {
        currentCustomer = data;
        refresh();
      },
    );
  }

  actionSubmit() async {
    List<Map<String, String>> salesItem = [];
    cartList?.forEach((p) {
      salesItem.add({
        'product_id': p.id,
        'price': p.price,
        'quantity': p.minOrder,
      });
    });
    var body = {
      'date': currentDate.toStr(),
      'warehouse': currentWarehouse?.id ?? '',
      'customer': currentCustomer?.id ?? '',
      'order_discount': sales?.orderDiscount ?? '',
      'shipping': sales?.shipping ?? '',
      'sale_status': sales?.saleStatus ?? 'pending',
      'payment_term': sales?.paymentTerm ?? '',
      'staff_note': sales?.staffNote ?? '',
      'note': sales?.note ?? '',
      'products': salesItem,
    };
    print('add sales $isAddDelivery $body');
    if (cartList?.isEmpty ?? true) {
      Get.defaultDialog(
        title: "Maaf",
        content: Text("Belum ada produk"),
        textCancel: "OK",
      );
      return;
    }
    await _actionPostSB(body);
  }

  goToAddDelivery(String idSalesBooking) async {
    Get.offNamedUntil(
      addDeliveryScreen,
      (route) => route.settings.name == homeScreen,
      arguments: {
        'customer': currentCustomer,
        'fromAddSales': idSalesBooking,
      },
    );
  }

  _actionPostSB(body) async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlAddSalesBooking,
      body,
      {},
      onBefore: (status) {},
      onSuccess: (data, _) {
        var response = BaseResponse.fromJson(data);
        if (isAddDelivery &&
            (response?.data?.salesBooking?.id?.isNotEmpty ?? false)) {
          goToAddDelivery(response?.data?.salesBooking?.id);
        } else {
          Get.snackbar('Sales', 'Tambah Penjualan Berhasil');
          Get.until((route) {
            if (route.settings.name == homeScreen) {
              var arg = (route.settings.arguments as Map);
              arg['result'] = DateTime.now().millisecondsSinceEpoch;
              arg['status'] = sales?.saleStatus;
              return true;
            } else {
              return false;
            }
          });
        }
      },
      onFailed: (title, message) {
        print(message);
        var errorData = BaseResponse.fromJson(jsonDecode(message));
        CustomDialog.showAlertDialog(Get.overlayContext,
            title: title,
            message: 'Kode error: ${errorData?.code}\n${errorData?.message}',
            leftAction: CustomDialog.customAction());
      },
      onError: (title, message) {
        CustomDialog.showAlertDialog(Get.overlayContext,
            title: title,
            message: message,
            leftAction: CustomDialog.customAction());
      },
      onAfter: (status) {},
    );
    status.execute();
  }
}
