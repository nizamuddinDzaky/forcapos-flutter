import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/product.dart';
import 'package:posku/model/warehouse.dart';
import 'package:posku/model/Purchase.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/supplier.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_string.dart';

class PurchaseController extends GetController {

  DateTime currentDate = DateTime.now();
  static PurchaseController get to => Get.find();
  List<Warehouse> listWarehouse = [];
  List<Supplier> listSupplier = [];
  List<Product> cartList;
  Warehouse currentWarehouse;
  Supplier currentSupplier;
  bool isFirst = true;
  List<Product> listProducts;
  List<Product> listSearch;
  Purchase purchase;

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

  actionGetSupplier() async {
    if (listSupplier.isNotEmpty) return;

    var status = await ApiClient.methodGet(
      ApiConfig.urlListSupplier,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        listSupplier.addAll(baseResponse?.data?.listSupplier ?? []);
      },
    );
    status.execute();
  }

  void setDate(DateTime newDateTime) {
    currentDate = newDateTime ?? currentDate;
    refresh();
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

  void showSupplierPicker(buildContext, {bool changeProduct : false}) {
    DataPicker.showDatePicker(
      buildContext,
      locale: 'id',
      datas: listSupplier,
      title: 'Pilih Pemasok',
      onConfirm: (data) {
        currentSupplier = data;
        if(changeProduct){
          isFirst = true;
        }
        refresh();
      },
    );
  }

  List<Product> getListProducts() {
    if (isFirst) {
      actionGetProduct();
    }
    return listSearch ?? listProducts;
  }

  actionGetProduct() async {
    /*debugPrint("jumlah prod : ${listProducts.length}");*/
    if (listProducts?.isNotEmpty ?? false) return;
    var params = {
      MyString.KEY_SUPPLIER_ID: currentSupplier?.id,
    };

    var status = await ApiClient.methodGet(
      ApiConfig.urlListProductPurchase,
      params: params,
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

  String getTotal() {
    var total = 0.0;
    cartList?.forEach((element) {
      total += element.minOrder.toDouble() * element.price.toDouble();
      total -= element.minOrder.toDouble() * element.discount.toDouble();
    });
    total -= purchase?.orderDiscount?.toDouble() ?? 0.0;
    total += purchase?.shipping?.toDouble() ?? 0.0;
    return total.toString().toRp();
  }

  void addToCart(Product p, {double qty = 1, double customQty}) {
    if (cartList == null) cartList = [];
    var order = p.minOrder.toDouble();
    p.minOrder = customQty?.toString() ?? (order + qty).toString();
    if (!cartList.contains(p)) cartList.add(p);
    refresh();
  }

  void deleteFromCart(Product p) {
    p.minOrder = null;
    cartList?.remove(p);
    refresh();
    Get.back();
  }

  actionSubmit() async {
    List<Map<String, String>> purchaseItem = [];
    cartList?.forEach((p) {
      purchaseItem.add({
        'product_id': p.id,
        'price': p.price,
        'quantity': p.minOrder,
        'product_discount' : p.discount,
      });
    });

    var body = {
      'date': currentDate.toStr(),
      'warehouse_id': currentWarehouse?.id ?? '',
      'supplier_id': currentSupplier?.id ?? '',
      'status': purchase?.status ?? 'pending',
      'shipping' : purchase?.shipping ?? '',
      'note': purchase?.note ?? '',
      'payment_term': purchase?.paymentTerm ?? '',
      'discount': purchase?.orderDiscount ?? '',
      'acceptor' : purchase?.receiver ?? '',
      'device_type' : 'Ios',
      'products' : purchaseItem,
      'no_si_spj' : purchase?.sinoSpj ?? '',
      'no_si_do' : purchase?.sinoDo ?? '',
      'no_si_billing' : purchase?.sinoBilling ?? ''
    };
    if (cartList?.isEmpty ?? true) {
      Get.defaultDialog(
        title: "Maaf",
        content: Text("Belum ada produk"),
        textCancel: "OK",
      );
      return;
    }
    await _actionPostPurchase(body);
  }

  _actionPostPurchase(body) async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlAddPurchase,
      body,
      {},
      onBefore: (status) {},
      onSuccess: (data, _) {
        /*var response = BaseResponse.fromJson(data);*/
        Get.snackbar('Sales', 'Tambah Penjualan Berhasil');
        Get.offNamedUntil(
          listPurchase,
              (route) => route.settings.name == homeScreen,
          arguments: body['status'],
        );
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