
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/app/my_router.dart';
import 'package:posku/helper/custom_cupertino_page_route.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/Purchase.dart';
import 'package:posku/model/company.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/purchase_items.dart';
import 'package:posku/model/supplier.dart';
import 'package:posku/model/warehouse.dart';
import 'package:posku/screen/purchase/edit_purchase_controller.dart';
import 'package:posku/screen/purchase/purchase_detail_screen.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class PurchaseDetailViewModel extends State<PurchaseDetailScreen> {
  bool isFirst = true;
  int sliding = 0;
  Purchase oldPo, newPo;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Customer customer;
  Supplier supplier;
  Warehouse warehouse;
  List<PurchaseItems> purchaseItems;
  Purchase get purchase => newPo ?? oldPo;

  Future<Null> actionRefresh() async {
    if (sliding == 0) {
      purchaseItems = null;
      customer = null;
      warehouse = null;
      supplier = null;
    } else if (sliding == 1) {
      /*listPayment = null;*/
    } else if (sliding == 2) {
      /*listDelivery = null;*/
    }
    setState(() {});
    return null;
  }

  /*@override
  void didChangeDependencies() {
    super.didChangeDependencies();

    (ModalRoute.of(context) as CustomCupertinoPageRoute)?.resultPop =
        Get.arguments;
  }*/

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
        customer = baseResponse?.data?.customer ?? Supplier();
        EditPurchaseController.to.customer = customer;
        /*EditSBController.to.customer = customer;*/
      },
      onAfter: (status) {
        updateState();
      },
    );
    status.execute();
    return null;
  }

  Future<Supplier> getDetailSupplier(String idSupplier) async {
    if (idSupplier == '1') {
      supplier = Supplier(name: 'Eceran', id: '1');
      return supplier;
    }
    if (supplier != null) return supplier;
    var params = {
      'id_supplier': idSupplier,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailSupplier,
      params: params,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        supplier = baseResponse?.data?.supplier ?? Supplier();
        EditPurchaseController.to.supplier = supplier;
      },
      onAfter: (status) {
        updateState();
      },
    );
    status.execute();
    return null;
  }

  Future<Warehouse> getDetailWarehouse(String idWarehouse) async {
    if (idWarehouse == '1') {
      warehouse = Warehouse(name: 'Eceran', id: '1');
      return warehouse;
    }
    if (warehouse != null) return warehouse;
    var params = {
      'id_warehouse': idWarehouse,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailWarehouse,
      params: params,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        warehouse = baseResponse?.data?.warehouse ?? Customer();
        EditPurchaseController.to.warehouse = warehouse;
      },
      onAfter: (status) {
        updateState();
      },
    );
    status.execute();
    return null;
  }

  Future<List<PurchaseItems>> getPurchaseItem(String idSales) async {
    if (purchaseItems != null) return purchaseItems;
    var params = {
      MyString.KEY_PURCHASES_ID: idSales,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailPurchase,
      params: params,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        newPo = baseResponse?.data?.purchase ?? purchase;
//        sb.paid = newSb.paid;
//        sb.grandTotal = newSb.grandTotal;
        purchaseItems = baseResponse?.data?.purchaseItems ?? [];
        EditPurchaseController.to.purchase = newPo;
        EditPurchaseController.to.purchaseItems = purchaseItems;
      },
      onAfter: (status) {
        updateState();
      },
    );
    status.execute();
    return null;
  }

  showOptionMenu(bool isEdit) {
    debugPrint("actionButton : $isEdit");
    final action = CupertinoActionSheet(
      title: Text('Menu Pembelian'),
      message: purchase?.referenceNo == null ? null : Text(purchase.referenceNo),
      actions: <Widget>[
        if (isEdit)
          CupertinoActionSheetAction(
            child: Text("Ubah Pembelian"),
            onPressed: () {
              Get.back();
              /*Get.snackbar("title", "message");*/
              goToEditPurchase();
            },
          ),
        if ((newPo ?? oldPo)?.status == 'received' && (newPo ?? oldPo)?.returnPurchaseRef == null)
          CupertinoActionSheetAction(
            child: Text("Kembalikan Pembelian"),
            onPressed: () {
              Get.back();
              goToReturnPurchase();
              /*actionClose();*/
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

  goToEditPurchase() async {
    var result = await Get.toNamed(
      editPurchaseScreen,
      arguments: {},
    );  
    if (result != null) {
      if (result == 'editPurchase') {
        purchaseItems = null;
        customer = null;
        warehouse = null;
        supplier = null;
        putArg(Get.arguments, 'result', 'editSales');
      }
      setState(() {});
    }
  }

  goToReturnPurchase() async {
    var result = await Get.toNamed(
      returnPurchase,
      arguments: {},
    );
    if (result != null) {
      if (result == 'editPurchase') {
        purchaseItems = null;
        customer = null;
        warehouse = null;
        supplier = null;
        putArg(Get.arguments, 'result', 'editSales');
      }
      setState(() {});
    }
  }

  updateState() {
    if (/*sbItems != null && */customer != null && supplier != null) {
      setState(() {});
    }
  }

  goToEditPayment(){
    Get.toNamed(
      editPaymentScreen,
      arguments: {
        /*'payment': payment.toJson(),*/
      },
    );
  }

  goToAddPayment(){
    Get.toNamed(
      addPaymentPurchaseScreen,
      arguments: {
        /*'payment': payment.toJson(),*/
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    if (Get.arguments != null && isFirst) {
      var arg = Get.arguments as Map<String, dynamic>;
      oldPo = Purchase.fromJson(arg ?? {});
      debugPrint("purchase : ${oldPo.companyId}");
    //*getListDelivery(oldSB.id);*//*
      isFirst = false;
    }
    Get.put(EditPurchaseController());
    super.initState();
  }
}