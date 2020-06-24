import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/customer_group.dart';
import 'package:posku/model/price_group.dart';
import 'package:posku/model/zone.dart';
import 'package:posku/util/my_util.dart';

class CustomerController extends GetController {
  static CustomerController get to => Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isEdit = false;
  Customer customer;
  Customer get checkCustomer {
    customer = customer ?? Customer();
    return customer;
  }
  List<PriceGroup> listPriceGroup = [];
  List<CustomerGroup> listCustomerGroup = [];
  List<Zone> listProvince, listCity, listState;
  Zone province, city, state;

  callAddress(buildContext, title, key) async {
    List<Zone> zones = await actionGetAddress(
      key,
      province: province?.txt,
      city: city?.txt,
    );
    if (zones != null) {
      DataPicker.showDatePicker(
        buildContext,
        locale: 'id',
        datas: zones,
        title: 'Pilih $title',
        onConfirm: (selected) {
          if (key == 'province') {
            province = selected;
            city = null;
            state = null;
            listCity = null;
            listState = null;
          }
          if (key == 'city') {
            city = selected;
            state = null;
            listState = null;
          }
          if (key == 'state') {
            state = selected;
          }
          refresh();
        },
      );
    } else {
    }
  }

  actionGetAddress(String key, {String province, String city}) async {
    if (key == 'province' && listProvince != null) return listProvince;
    if (key == 'city' && listCity != null) return listCity;
    if (key == 'state' && listState != null) return listState;
    var params = {
      if (province != null) 'province': province,
      if (city != null) 'city': city,
    };
    var url = ApiConfig.urlListProvince;
    if (key == 'city') url = ApiConfig.urlListCity;
    if (key == 'state') url = ApiConfig.urlListStates;
    List<Zone> zones;
    var status = await ApiClient.methodGet(
      url,
      params: params,
      onBefore: (status) {},
      onSuccess: (data, _) {
        print('dapat dat $data');
        if (data['data'] != null && data['data'] is List) {
          zones = [];
        }
        if (key == 'province' && data['data'] is List) {
          zones.addAll((data['data'] as List)
              .map((obj) => Zone.fromJson(obj)..toProvince())
              .toList());
          listProvince = zones;
        }
        if (key == 'city' && data['data'] is List) {
          zones.addAll((data['data'] as List)
              .map((obj) => Zone.fromJson(obj)..toCity())
              .toList());
          listCity = zones;
        }
        if (key == 'state' && data['data'] is List) {
          zones.addAll((data['data'] as List)
              .map((obj) => Zone.fromJson(obj)..toState())
              .toList());
          listState = zones;
        }
        return zones;
      },
      onFailed: (title, message) {
        Get.snackbar(title, message);
      },
      onError: (title, message) {
        Get.snackbar(title, message);
      },
      onAfter: (status) {},
    );
    await status.execute();
    return Future.value(zones);
  }


  var statusCustomer = [
    ['Aktif', '1'],
    ['Non-aktif', '0'],
  ];

  CustomerController({this.customer}){
    this.isEdit = customer != null;
    print('terdeteksi ubah $isEdit');
    if (this.isEdit) {
      province = Zone()..txt = customer?.country;
      city = Zone()..txt = customer?.city;
      state = Zone()..txt = customer?.state;
    }
  }

  refresh() {
    update();
  }

  saveForm(
      {name,
      company,
      email,
      phone,
      address,
      postalCode,
      vatNo,
      cf1,
      priceGroupId,
      priceGroupName,
      customerGroupId,
      customerGroupName}) {
    customer = customer ?? Customer();
    customer.name = name ?? customer.name;
    customer.company = company ?? customer.company;
    customer.email = email ?? customer.email;
    customer.phone = phone ?? customer.phone;
    customer.address = address ?? customer.address;
    customer.postalCode = postalCode ?? customer.postalCode;
    customer.vatNo = vatNo ?? customer.vatNo;
    customer.cf1 = cf1 ?? customer.cf1;
    customer.priceGroupId = priceGroupId ?? customer.priceGroupId;
    customer.priceGroupName = priceGroupName ?? customer.priceGroupName;
    customer.customerGroupId = customerGroupId ?? customer.customerGroupId;
    customer.customerGroupName =
        customerGroupName ?? customer.customerGroupName;
  }

  actionSubmit() async {
    formKey.currentState.save();
    var body = {
      'name': customer?.name,
      'company': customer?.company,
      'customer_group_id': customer?.customerGroupId,
      //'': customer?.customerGroupName,
      'price_group_id': customer?.priceGroupId,
      //'': customer?.priceGroupName,
      'email': customer?.email,
      'phone': customer?.phone,
      'address': customer?.address,
      'province': province?.txt,
      'city': city?.txt,
      'state': state?.txt,
      'postal_code': customer?.postalCode,
      'vat_no': customer?.vatNo,
      //'cf1': customer?.cf1,
      'is_active': customer?.isActive,
    };
    print('action api ${isEdit ? 'edit' : 'add'} customer $body');
    if (isEdit) {
      await actionPutEditCustomer(body);
    } else {
      await actionPostAddCustomer(body);
    }
  }

  actionPutEditCustomer(body) async {
    var params = {
      'id_customer': customer?.id,
    };
    var status = await ApiClient.methodPut(
      ApiConfig.urlUpdateCustomer,
      body,
      params,
      onBefore: (status) {},
      onSuccess: (data, _) {
        Get.snackbar('Pelanggan', 'Ubah Pelanggan Berhasil');
        Get.back(result: 'editCustomer');
      },
      onFailed: (title, message) {
        print(message);
        var errorData = BaseResponse.fromJson(tryJsonDecode(message) ?? {});
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

  actionPostAddCustomer(body) async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlAddCustomer,
      body,
      {},
      onBefore: (status) {},
      onSuccess: (data, _) {
        Get.snackbar('Pelanggan', 'Tambah Pelanggan Berhasil');
        Get.back(result: 'addCustomer');
      },
      onFailed: (title, message) {
        print(message);
        var errorData = BaseResponse.fromJson(tryJsonDecode(message) ?? {});
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

  actionGetCustomerGroup() async {
    if (listCustomerGroup.isNotEmpty) return;

    var status = await ApiClient.methodGet(
      ApiConfig.urlListCustomerGroup,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        listCustomerGroup.addAll(baseResponse?.data?.customerGroups ?? []);
      },
    );
    status.execute();
  }

  void showCustomerGroupPicker(buildContext) {
    DataPicker.showDatePicker(
      buildContext,
      locale: 'id',
      datas: listCustomerGroup,
      title: 'Pilih Kel. Pelanggan',
      onConfirm: (data) {
        CustomerGroup cg = data;
        print('data ${cg.toJson()}');
        saveForm(customerGroupId: cg?.id, customerGroupName: cg?.name);
        refresh();
      },
    );
  }

  actionGetPriceGroup() async {
    if (listPriceGroup.isNotEmpty) return;

    var status = await ApiClient.methodGet(
      ApiConfig.urlListPriceGroup,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        listPriceGroup.addAll(baseResponse?.data?.priceGroups ?? []);
      },
    );
    status.execute();
  }

  void showPriceGroupPicker(buildContext) {
    DataPicker.showDatePicker(
      buildContext,
      locale: 'id',
      datas: listPriceGroup,
      title: 'Pilih Kel. Harga',
      onConfirm: (data) {
        PriceGroup pg = data;
        saveForm(priceGroupId: pg?.id, priceGroupName: pg?.name);
        refresh();
      },
    );
  }
}
