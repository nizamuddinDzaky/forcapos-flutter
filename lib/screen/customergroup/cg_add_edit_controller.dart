import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/customer_group.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_string.dart';

class CGAddEditController extends GetController {
  CGAddEditController get to => Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CustomerGroup customerGroup;
  bool isEdit = false;

  CGAddEditController(this.customerGroup) {
    this.isEdit = customerGroup != null;
//    if (customerGroup?.warehouseId != null)
//      actionGetWarehouse();
  }

  refresh() {
    update();
  }

  saveForm({String name, String limit, String percent}) {
    customerGroup = customerGroup ?? CustomerGroup();
    customerGroup.name = name?.trim() ?? customerGroup.name;
    customerGroup.kreditLimit = limit ?? customerGroup.kreditLimit;
    customerGroup.percent = percent ?? customerGroup.percent;
  }

  actionSubmitAdd() async {
    formKey.currentState.save();
    if (0 == customerGroup?.name?.length ?? 0) {
      CustomDialog.showAlertDialog(Get.overlayContext,
          title: 'Perhatian',
          message: 'Isi semua kolom.',
          leftAction: CustomDialog.customAction());
      return;
    }
    var body = {
      'name': customerGroup?.name,
      if (customerGroup?.percent != null)
        'percentage': customerGroup?.percent?.tryIDtoDouble(),
      if (customerGroup?.kreditLimit != null)
        'credit_limit': customerGroup?.kreditLimit?.tryIDtoDouble(),
    };
    print('api body price group $isEdit $body');
    if (isEdit) {
      await apiPutEditCustomerGroup(body);
    } else {
      await apiPostAddCustomerGroup(body);
    }
  }

  apiPutEditCustomerGroup(body) async {
    var params = {
      MyString.KEY_ID_CUSTOMER_GROUP: customerGroup?.id,
    };
    var status = await ApiClient.methodPut(
      ApiConfig.urlCustomerGroupUpdate,
      body,
      params,
      onBefore: (status) {},
      onSuccess: (data, _) {
        Get.snackbar('Kelompok Pelanggan', 'Ubah Kelompak Pelanggan Berhasil');
        Get.back(result: 'editCustomerGroup');
      },
      onFailed: (title, message) {
        print(message);
        var errorData = BaseResponse.fromJson(tryJsonDecode(message) ?? {});
        CustomDialog.showAlertDialog(Get.overlayContext,
            title: title,
            message: 'Kode error: ${errorData?.code}',
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

  apiPostAddCustomerGroup(body) async {
    var status = await ApiClient.methodPost(
      ApiConfig.urlAddPriceGroupCustomer,
      body,
      {},
      onBefore: (status) {},
      onSuccess: (data, _) {
        Get.snackbar('Kelompok Harga', 'Tambah Kelompak Harga Berhasil');
        Get.back(result: 'addPriceGroup');
      },
      onFailed: (title, message) {
        print(message);
        var errorData = BaseResponse.fromJson(tryJsonDecode(message) ?? {});
        CustomDialog.showAlertDialog(Get.overlayContext,
            title: title,
            message: 'Kode error: ${errorData?.code}',
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
