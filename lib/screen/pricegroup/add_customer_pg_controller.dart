import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/price_group.dart';
import 'package:posku/util/my_util.dart';
import 'package:posku/util/resource/my_string.dart';

class AddCustomerPGController extends GetController {
  static AddCustomerPGController get to => Get.find();

  List<Customer> selectedCustomer;

  List<Customer> get selectedCustomers {
    List<Customer> newList = []..addAll(selectedCustomer ?? []);
    var max = 4 - newList.length;
    for (var i = 0; i < max; i++) {
      newList.add(null);
    }
    var a = selectedCustomer?.length ?? 0;
    var b = newList?.length ?? 0;
    var c = listCustomers?.length ?? 0;
    if (c > 4 && a >= b && a < c) {
      newList.add(null);
    }
    //print('cek selected customer ${newList.map((e) => e?.id).join(',')}');
    return newList;
  }

  List<Customer> get listCustomer => listSearch ?? listCustomers;
  List<Customer> listCustomers;
  List<Customer> listSearch;
  PriceGroup pg;

  AddCustomerPGController(this.pg) {
    apiGetCustomer();
  }

  refresh() {
    update();
  }

  apiGetCustomer() async {
    var params = {
      MyString.KEY_ID_PRICE_GROUP: pg?.id,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlMemberPriceGroup,
      params: params,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        listCustomers = baseResponse?.data?.listCustomers;
        var selected =
            baseResponse?.data?.customerSelected?.map((e) => e.id)?.toList();
        if (selected != null) {
          listCustomers.forEach((customer) {
            if (selected.contains(customer.id)) {
              selectCustomer(customer);
            }
          });
        }
      },
      onFailed: (title, message) {
        print('cek data $message $title');
      },
      onError: (title, message) {
        print('cek data $message $title');
      },
      onAfter: (status) {
        update();
      },
    );
    status.execute();
  }

  actionSubmit() async {
    var body = {
      'id_customer': selectedCustomer?.map((e) => e.id)?.toList(),
    };
    print('add price group $body');
    await _actionPostCustomerToPG(body);
  }

  _actionPostCustomerToPG(body) async {
    var params = {
      MyString.KEY_ID_PRICE_GROUP: pg?.id,
    };
    var status = await ApiClient.methodPost(
      ApiConfig.urlCustomerToPGAddEdit,
      body,
      params,
      onSuccess: (data, _) {
        print('cek berhasil ${data['data']}');
        Get.snackbar('Kelompok Harga', 'Perubahan Data Berhasil');
        Get.back(result: 'editPriceGroup');
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

  actionSearch(String txtSearch) async {
    if (txtSearch == null || txtSearch.length < 3) {
      listSearch?.clear();
      listSearch = null;
    } else {
      listSearch = [];
      listSearch.addAll(listCustomers?.where((customer) =>
          cekEquals(customer.address, txtSearch) ||
          cekEquals(customer.region, txtSearch) ||
          cekEquals(customer.state, txtSearch) ||
          cekEquals(customer.country, txtSearch) ||
          cekEquals(customer.postalCode, txtSearch) ||
          cekEquals(customer.company, txtSearch) ||
          cekEquals(customer.name, txtSearch)));
    }
    update();
  }

  bool cekEquals(String ref, String key) {
    return ref?.toLowerCase()?.contains(key) ?? false;
  }

  cancelSearch() {
    listSearch?.clear();
    listSearch = null;
    update();
  }

  bool selectCustomer(Customer customer) {
    selectedCustomer = selectedCustomer ?? [];
    if (!selectedCustomer.contains(customer)) {
      customer.flag = '1';
      selectedCustomer?.insert(0, customer);
      return false;
    }
    return true;
  }

  removeCustomer(Customer customer) {
    customer.flag = null;
    selectedCustomer?.remove(customer);
  }

  selectOrRemove(Customer customer) {
    if (selectCustomer(customer)) {
      removeCustomer(customer);
    }
    update();
  }

  removeAll() {
    listCustomers.forEach((customer) {
      removeCustomer(customer);
    });
    selectedCustomer.clear();
    update();
  }

  addAll() {
    listCustomers.forEach((customer) {
      selectCustomer(customer);
    });
    update();
  }
}
