import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/price_group.dart';
import 'package:posku/model/warehouse.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_string.dart';

class PriceGroupController extends GetController {
  PriceGroupController get to => Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PriceGroup priceGroup;
  bool isEdit = false;
  List<Warehouse> listWarehouse = [];
  Warehouse warehouse;

  PriceGroupController(this.priceGroup) {
    this.isEdit = priceGroup != null;
    if (priceGroup?.warehouseId != null)
      actionGetWarehouse();
  }

  refresh() {
    update();
  }

  actionGetWarehouse() async {
    if (listWarehouse.isNotEmpty) return;

    var status = await ApiClient.methodGet(
      ApiConfig.urlListWarehouse,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        listWarehouse.addAll(baseResponse?.data?.listWarehouses ?? []);
        listWarehouse?.forEach((warehouse) {
          if (warehouse.id == priceGroup?.warehouseId) {
            this.warehouse = warehouse;
            this.refresh();
            return;
          }
        });
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
        warehouse = data;
        refresh();
      },
    );
  }

  saveForm({String name}) {
    priceGroup = priceGroup ?? PriceGroup();
    priceGroup.name = name?.trim() ?? priceGroup.name;
  }

  actionSubmitAdd() async {
    formKey.currentState.save();
    if (0 == priceGroup?.name?.length ?? 0) {
      CustomDialog.showAlertDialog(Get.overlayContext,
          title: 'Perhatian',
          message: 'Isi semua kolom.',
          leftAction: CustomDialog.customAction());
      return;
    }
    var body = {
      'name': priceGroup?.name,
      if (priceGroup?.warehouseId != null)
        'warehouse_id': priceGroup?.warehouseId,
      if (warehouse?.id != null)
        'warehouse_id': warehouse?.id,
    };
    print('api body price group $isEdit $body');
    if (isEdit) {
      await apiPutEditPriceGroup(body);
    } else {
      await apiPostAddPriceGroup(body);
    }
  }

  apiPutEditPriceGroup(body) async {
    var params = {
      MyString.KEY_ID_PRICE_GROUP: priceGroup?.id,
    };
    var status = await ApiClient.methodPut(
      ApiConfig.urlPriceGroupUpdate,
      body,
      params,
      onBefore: (status) {},
      onSuccess: (data, _) {
        Get.snackbar('Kelompok Harga', 'Ubah Kelompak Harga Berhasil');
        Get.back(result: 'editPriceGroup');
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

  apiPostAddPriceGroup(body) async {
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
