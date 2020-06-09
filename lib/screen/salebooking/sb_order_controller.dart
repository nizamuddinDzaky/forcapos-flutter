import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/product.dart';
import 'package:posku/model/warehouse.dart';
import 'package:posku/util/my_util.dart';

class SBOrderController extends GetController {
  static SBOrderController get to => Get.find();

  DateTime currentDate = DateTime.now();
  List<Product> cartList;
  List<Product> listProducts;
  List<Product> listSearch;
  Warehouse currentWarehouse;
  List<Warehouse> listWarehouse = [];
  Customer currentCustomer;
  List<Customer> listCustomer = [];
  bool isFirst = true;

  String getTotal() {
    var total = 0.0;
    cartList?.forEach((element) {
      total += element.minOrder.toDouble() * element.price.toDouble();
    });
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
    update(this);
  }

  cancelSearch() {
    listSearch?.clear();
    listSearch = null;
    update(this);
  }

  void deleteFromCart(Product p) {
    p.minOrder = null;
    cartList?.remove(p);
    update(this);
    Get.back();
  }

  void addToCart(Product p, {double qty = 1, double customQty}) {
    if (cartList == null) cartList = [];
    var order = p.minOrder.toDouble();
    p.minOrder = customQty?.toString() ?? (order + qty).toString();
    if (!cartList.contains(p))
      cartList.add(p);
    update(this);
  }

  List<Product> getListProducts() {
    if (isFirst) {
      actionGetProduct();
    }
    return listSearch ?? listProducts;
  }

  void setDate(DateTime newDateTime) {
    currentDate = newDateTime ?? currentDate;
    update(this);
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
        update(this);
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
        update(this);
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
        update(this);
      },
    );
  }
}