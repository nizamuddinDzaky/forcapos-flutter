import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/product.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/model/sales_booking_item.dart';
import 'package:posku/model/warehouse.dart';
import 'package:posku/util/my_util.dart';

class EditSBController extends GetController {
  static EditSBController get to => Get.find();

  SalesBooking cSales;
  List<SalesBookingItem> cSalesItem;
  Customer cCustomer;
  Warehouse cWarehouse;
  List<Product> listProducts;
  List<Product> listSearch;
  List<Warehouse> listWarehouse = [];
  List<Customer> listCustomer = [];

  SalesBooking get sales => cSales;

  List<SalesBookingItem> get salesItem => cSalesItem;

  Customer get customer => cCustomer;

  Warehouse get warehouse => cWarehouse;

  void refresh() {
    update(this);
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

  set salesItem(List<SalesBookingItem> salesItem) {
    if (salesItem != null) {
      cSalesItem = [];
      salesItem.forEach((sbi) {
        cSalesItem.add(SalesBookingItem(
          id: sbi.id,
          productName: sbi.productName,
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
