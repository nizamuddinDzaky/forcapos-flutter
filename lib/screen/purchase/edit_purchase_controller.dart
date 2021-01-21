import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/Purchase.dart';
import 'package:posku/model/company.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/purchase_items.dart';
import 'package:posku/model/supplier.dart';
import 'package:posku/model/warehouse.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_string.dart';

class EditPurchaseController extends GetController {
  static EditPurchaseController get to => Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Supplier cSupplier;
  Purchase cPurchase;
  Customer cCustomer;
  Warehouse cWarehouse;
  List<PurchaseItems> cPurchaseItems;
  List<Warehouse> listWarehouse = [];
  List<Supplier> listSupplier = [];
  PurchaseItems editPI;

  Supplier get supplier => cSupplier;
  Purchase get purchase => cPurchase;
  Customer get customer => cCustomer;
  Warehouse get warehouse => cWarehouse;
  List<PurchaseItems> get purchaseItems => cPurchaseItems;
  bool isReceived = false;
  void refresh() {
    update();
  }

  double totalPurchaseItem(PurchaseItems sbi) {
    var total = 0.0;
    total +=
        (sbi.quantity?.toDouble() ?? 0) * (sbi.netUnitCost?.toDouble() ?? 0);
    total -= sbi.discount?.toDouble() ?? 0;
    return total;
  }

  double threshold(double current) {
    return current < 1 ? 1 : current;
  }

  double thresholdReceived(double current, double max) {
    return current < 1 ? 1 : (current > max ? max : current );
  }

  double grandTotal() {
    var total = 0.0;
    purchaseItems?.forEach((sbi) {
      total += totalPurchaseItem(sbi);
    });
    total -= purchase?.orderDiscount?.toDouble() ?? 0;
    total += purchase?.shipping?.toDouble() ?? 0;
    return total;
  }

  editPurchase({
    orderDiscount,
    shipping,
    paymentTerm,
    receiver,
    note,
    sinoSpj,
    sinoDo,
    sinoBilling
  }) {
    purchase?.orderDiscount = orderDiscount ?? purchase?.orderDiscount;
    purchase?.shipping = shipping ?? purchase?.shipping;
    purchase?.paymentTerm = paymentTerm ?? purchase?.paymentTerm;
    purchase?.receiver = receiver ?? purchase?.receiver;
    purchase?.note = note ?? purchase?.note;
    purchase?.sinoSpj = note ?? purchase?.sinoSpj;
    purchase?.sinoDo = note ?? purchase?.sinoDo;
    purchase?.sinoBilling = note ?? purchase?.sinoBilling;

    refresh();
  }

  qtyMinus(PurchaseItems pi) {
    pi.quantity = threshold((pi.quantity?.toDouble() ?? 0) - 1).toString();
    refresh();
  }

  qtyPlus(PurchaseItems pi) {
    pi.quantity = threshold((pi.quantity?.toDouble() ?? 0) + 1).toString();
    refresh();
  }

  qtyCustom(PurchaseItems pi, {double qty, String qtyStr}) {
    pi.quantity = threshold(qty ?? qtyStr?.toDoubleID() ?? 0).toString();
    refresh();
  }

  qtyMinusReceived(PurchaseItems pi) {
    pi.quantityReceived = thresholdReceived((pi.quantityReceived?.toDouble() ?? 0) - 1, pi.quantity.toDouble()).toString();
    refresh();
  }

  qtyPlusReceived(PurchaseItems pi) {
    pi.quantityReceived = thresholdReceived((pi.quantityReceived?.toDouble() ?? 0) + 1, pi.quantity.toDouble()).toString();
    refresh();
  }

  qtyCustomReceived(PurchaseItems pi, {double qty, String qtyStr}) {
    pi.quantityReceived = thresholdReceived(qty ?? qtyStr?.toDoubleID() ?? 0, pi.quantity.toDouble()).toString();
    refresh();
  }
  qtyCustomReturned(PurchaseItems pi, {double qty, String qtyStr}) {
    pi.quantityReturn = thresholdReceived(qty ?? qtyStr?.toDoubleID() ?? 0, pi.quantity.toDouble()).toString();
    refresh();
  }


  qtyMinusReturned(PurchaseItems pi) {
    pi.quantityReturn = thresholdReceived((pi.quantityReturn?.toDouble() ?? 0) - 1, pi.quantity.toDouble()).toString();
    refresh();
  }

  qtyPlusReturned(PurchaseItems pi) {
    pi.quantityReturn = thresholdReceived((pi.quantityReturn?.toDouble() ?? 0) + 1, pi.quantity.toDouble()).toString();
    refresh();
  }

  toEditItem(PurchaseItems sbi) async {
    editPI = sbi;
    Get.snackbar("title", "message");
    editPI = null;
  }

  deleteFromCart(PurchaseItems sbi) {
    sbi.quantity = null;
    purchaseItems?.remove(sbi);
    Get.back();
    refresh();
  }

  qtyEdit(TextEditingController controller, {double qty, String qtyStr}) {
    if (qtyStr.isEmpty) return;
    var newQty = threshold(qty ?? qtyStr?.toDoubleID() ?? 0);
    lastCursorEditText(controller, newQty);
  }

  qtyEditReceived(TextEditingController controller, {double qty, String qtyStr, PurchaseItems pi}) {
    if (qtyStr.isEmpty) return;
    var newQty = thresholdReceived(qty ?? qtyStr?.toDoubleID() ?? 0, pi.quantity.toDouble());
    lastCursorEditText(controller, newQty);
  }

  qtyEditReturned(TextEditingController controller, {double qty, String qtyStr, PurchaseItems pi}) {
    if (qtyStr.isEmpty) return;
    var newQty = thresholdReceived(qty ?? qtyStr?.toDoubleID() ?? 0, pi.quantity.toDouble());
    lastCursorEditText(controller, newQty);
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

  void showWarehousePicker(buildContext) {
    DataPicker.showDatePicker(
      buildContext,
      locale: 'id',
      datas: listWarehouse,
      title: 'Pilih Gudang',
      onConfirm: (data) {
        cWarehouse = data;
        refresh();
      },
    );
  }

  actionSubmitReturn() async {
    formKey.currentState.save();
    Map<String, dynamic> body = {
      'date': purchase?.date,
      "id_purchases" : purchase.id,
      'products': purchaseItems?.map((sbi) => {
        'product_id': sbi.productId,
        'purchase_item_id' : sbi.id,
        'quantity' : sbi.quantityReturn
      })?.toList(),
    };
    debugPrint("body : ${body}");
    actionPostReturnPurchase(body);
  }

  actionPostReturnPurchase(Map<String, dynamic> body) async {
    /*var params = {
      MyString.KEY_PURCHASE_ID: purchase.id,
    };*/
    var status = await ApiClient.methodPost(
      ApiConfig.urlReturnPurchase,
      body,
      {},
      onBefore: (status) {},
      onSuccess: (data, _) {
        Get.snackbar('Penjualan', 'Berhasil diperbaharui');
        Get.back(result: 'editPurchase');
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

  actionSubmit() async {
    formKey.currentState.save();
    //await Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> body = {
      'date': purchase?.date,
      'supplier_id': supplier?.id,
      'warehouse_id': warehouse?.id,
      'reference_no' : purchase?.referenceNo,
      'discount': purchase?.orderDiscount,
      'shipping': purchase?.shipping,
      'status': purchase?.status,
      'payment_term': purchase?.paymentTerm,
      'acceptor': purchase?.receiver,
      'note': purchase?.note,
      'no_si_spj' : purchase?.sinoSpj ?? '',
      'no_si_do' : purchase?.sinoDo ?? '',
      'no_si_billing' : purchase?.sinoBilling ?? '',
      'products': purchaseItems?.map((sbi) => {
        'product_id': sbi.productId,
        'price': sbi.netUnitCost,
        'quantity': sbi.quantity,
        'received_quantity' : sbi.quantityReceived
      })?.toList(),
    };
    print('action put sales $body');
    await actionPutPurchase(body);
  }

  actionPutPurchase(Map<String, dynamic> body) async {
    var params = {
      MyString.KEY_PURCHASE_ID: purchase.id,
    };
    var status = await ApiClient.methodPut(
      ApiConfig.urlUpdatePurchase,
      body,
      params,
      onBefore: (status) {},
      onSuccess: (data, _) {
        Get.snackbar('Penjualan', 'Berhasil diperbaharui');
        Get.back(result: 'editPurchase');
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

  void showSupplierPicker(buildContext, {bool changeProduct : false}) {
    DataPicker.showDatePicker(
      buildContext,
      locale: 'id',
      datas: listSupplier,
      title: 'Pilih Pemasok',
      onConfirm: (data) {
        cSupplier = data;
        /*if(changeProduct){
          isFirst = true;
        }*/
        refresh();
      },
    );
  }

  set purchaseItems(List<PurchaseItems> purchaseItems) {
    if (purchaseItems != null) {
      cPurchaseItems = [];
      purchaseItems.forEach((pi) {
        cPurchaseItems.add(PurchaseItems(
          id: pi.id,
          productName: pi.productName,
          productId: pi.productId,
          productCode: pi.productCode,
          quantity: pi.quantity,
          discount: pi.discount,
          netUnitCost: pi.netUnitCost,
          unitCost: pi.unitCost,
          quantityReceived: pi.quantityReceived
        ));
      });
    }
  }

  set purchase(Purchase purchase) {
    if (purchase != null) {
      cPurchase = Purchase(
        id: purchase.id,
        date: purchase.date,
        supplierId: purchase.supplierId,
        supplier: purchase.supplier,
        warehouseId: purchase.warehouseId,
        orderDiscount: purchase.orderDiscount,
        shipping: purchase.shipping,
        status: purchase.status,
        paymentTerm: purchase.paymentTerm,
        note: purchase.note,
        sinoBilling: purchase.sinoBilling,
        sinoDo: purchase.sinoDo,
        sinoSpj: purchase.sinoSpj,
        receiver: purchase.receiver,
        referenceNo: purchase.referenceNo
      );
    }
  }

  set customer(Customer customer) {
    if (customer != null) {
      cCustomer = Customer(
        id: customer.id,
        name: customer.name,
      );
    }
  }

  set supplier(Supplier supplier) {
    if (supplier != null) {
      cSupplier = Supplier(
        id: supplier.id,
        name: supplier.name,
      );
    }
  }

  set warehouse(Warehouse warehouse) {
    if (warehouse != null) {
      cWarehouse = Warehouse(
        id: warehouse.id,
        name: warehouse.name,
      );
    }
  }
}