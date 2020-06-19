import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/product.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/model/sales_booking_item.dart';
import 'package:posku/model/warehouse.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/util/resource/my_string.dart';

class EditSBController extends GetController {
  static EditSBController get to => Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SalesBooking cSales;
  List<SalesBookingItem> cSalesItem;
  Customer cCustomer;
  Warehouse cWarehouse;
  List<Product> listProducts;
  List<Product> listSearch;
  List<Warehouse> listWarehouse = [];
  List<Customer> listCustomer = [];
  SalesBookingItem editSBI;

  SalesBooking get sales => cSales;

  List<SalesBookingItem> get salesItem => cSalesItem;

  Customer get customer => cCustomer;

  Warehouse get warehouse => cWarehouse;

  void refresh() {
    update();
  }

  List<Product> getListProducts() {
    return listSearch ?? listProducts;
  }

  bool checkItemIsExist(Product p) {
    return salesItem.where((sbi) => sbi.productId == p.id).toList().isNotEmpty;
  }

  toEditItem(SalesBookingItem sbi) async {
    editSBI = sbi;
    await Get.toNamed(editSBItemScreen);
    editSBI = null;
  }

  toAddItem() {
    cancelSearch();
    Get.toNamed(editSBProductScreen);
  }

  addProduct(Product p) {
    if (checkItemIsExist(p)) return;
    if (cSalesItem == null) cSalesItem = [];
    cSalesItem.add(SalesBookingItem(
      productName: p.name,
      productId: p.id,
      productCode: p.code,
      quantity: '1.0',
      discount: '0.0',
      netUnitPrice: p.price,
    ));
    refresh();
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

  double totalSaleBookingItem(SalesBookingItem sbi) {
    var total = 0.0;
    total +=
        (sbi.quantity?.toDouble() ?? 0) * (sbi.netUnitPrice?.toDouble() ?? 0);
    total -= sbi.discount?.toDouble() ?? 0;
    return total;
  }

  double grandTotal() {
    var total = 0.0;
    salesItem?.forEach((sbi) {
      total += totalSaleBookingItem(sbi);
    });
    total -= sales?.orderDiscount?.toDouble() ?? 0;
    total += sales?.shipping?.toDouble() ?? 0;
    return total;
  }

  double threshold(double current) {
    return current < 1 ? 1 : current;
  }

  qtyMinus(SalesBookingItem sbi) {
    sbi.quantity = threshold((sbi.quantity?.toDouble() ?? 0) - 1).toString();
    refresh();
  }

  qtyPlus(SalesBookingItem sbi) {
    sbi.quantity = threshold((sbi.quantity?.toDouble() ?? 0) + 1).toString();
    refresh();
  }

  qtyCustom(SalesBookingItem sbi, {double qty, String qtyStr}) {
    sbi.quantity = threshold(qty ?? qtyStr?.toDoubleID() ?? 0).toString();
    refresh();
  }

  qtyEdit(TextEditingController controller, {double qty, String qtyStr}) {
    if (qtyStr.isEmpty) return;
    var newQty = threshold(qty ?? qtyStr?.toDoubleID() ?? 0);
    lastCursorEditText(controller, newQty);
  }

  deleteFromCart(SalesBookingItem sbi) {
    sbi.quantity = null;
    salesItem?.remove(sbi);
    Get.back();
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
    if (listProducts?.isNotEmpty ?? false) {
      toAddItem();
      return;
    }

    var status = await ApiClient.methodGet(
      ApiConfig.urlListProduct,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        if (listProducts == null) listProducts = [];
        listProducts.addAll(baseResponse?.data?.listProducts ?? []);
        refresh();
      },
      onAfter: (_) {
        toAddItem();
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

  void showCustomerPicker(buildContext) {
    DataPicker.showDatePicker(
      buildContext,
      locale: 'id',
      datas: listCustomer,
      title: 'Pilih Pelanggan',
      onConfirm: (data) {
        cCustomer = data;
        refresh();
      },
    );
  }

  editSales({orderDiscount, shipping, paymentTerm, staffNote, note}) {
    sales?.orderDiscount = orderDiscount ?? sales?.orderDiscount;
    sales?.shipping = shipping ?? sales?.shipping;
    sales?.paymentTerm = paymentTerm ?? sales?.paymentTerm;
    sales?.staffNote = staffNote ?? sales?.staffNote;
    sales?.note = note ?? sales?.note;
    refresh();
  }

  actionSubmit() async {
    formKey.currentState.save();
    //await Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> body = {
      'date': sales?.date,
      'customer': customer?.id,
      'warehouse': warehouse?.id,
      'order_discount': sales?.orderDiscount,
      'shipping': sales?.shipping,
      'sale_status': sales?.saleStatus,
      'payment_term': sales?.paymentTerm,
      'staff_note': sales?.staffNote,
      'note': sales?.note,
      'products': salesItem?.map((sbi) => {
        'product_id': sbi.productId,
        'price': sbi.netUnitPrice,
        'quantity': sbi.quantity,
      })?.toList(),
    };
    print('action put sales $body');
    await actionPutSales(body);
  }

  actionPutSales(Map<String, dynamic> body) async {
    var params = {
      MyString.KEY_ID_SALES_BOOKING: sales.id,
    };
    var status = await ApiClient.methodPut(
      ApiConfig.urlSalesBookingUpdate,
      body,
      params,
      onBefore: (status) {},
      onSuccess: (data, _) {
        Get.snackbar('Penjualan', 'Berhasil diperbaharui');
        Get.back(result: 'editSales');
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

  set salesItem(List<SalesBookingItem> salesItem) {
    if (salesItem != null) {
      cSalesItem = [];
      salesItem.forEach((sbi) {
        cSalesItem.add(SalesBookingItem(
          id: sbi.id,
          productName: sbi.productName,
          productId: sbi.productId,
          productCode: sbi.productCode,
          quantity: sbi.quantity,
          discount: sbi.discount,
          netUnitPrice: sbi.netUnitPrice,
        ));
      });
    }
  }

  set sales(SalesBooking sales) {
    if (sales != null) {
      cSales = SalesBooking(
        id: sales.id,
        date: sales.date,
        customer: sales.customer,
        customerId: sales.customerId,
        warehouseId: sales.warehouseId,
        orderDiscount: sales.orderDiscount,
        shipping: sales.shipping,
        saleStatus: sales.saleStatus,
        paymentTerm: sales.paymentTerm,
        staffNote: sales.staffNote,
        note: sales.note,
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

  set warehouse(Warehouse warehouse) {
    if (warehouse != null) {
      cWarehouse = Warehouse(
        id: warehouse.id,
        name: warehouse.name,
      );
    }
  }
}
