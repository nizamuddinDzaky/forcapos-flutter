import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/customer_group.dart';
import 'package:posku/util/resource/my_string.dart';

class CustomerGroupController extends GetController {
  static CustomerGroupController get to => Get.find();

  List<Customer> selectedCustomer;
  List<Customer> listCustomer;
  CustomerGroup cg;

  CustomerGroupController(this.cg) {
    apiGetCustomer();
  }

  apiGetCustomer() async {
    var params = {
      MyString.KEY_ID_CUSTOMER_GROUP: cg?.id,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlMemberCustomerGroup,
      params: params,
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        listCustomer = baseResponse?.data?.listCustomers;
        var selected =
            baseResponse?.data?.customerSelected?.map((e) => e.id)?.toList();
        if (selected != null) {
          listCustomer.forEach((customer) {
            if (selected.contains(customer.id)) {
              selectCustomer(customer);
            }
          });
        }
        print('cek data ${data['data']['list_customer'][0].keys}');
      },
//      onFailed: (title, message) {
//        Get.defaultDialog(title: title, content: Text(message));
//      },
//      onError: (title, message) {
//        Get.defaultDialog(title: title, content: Text(message));
//      },
      onAfter: (status) {
        update();
      },
    );
    status.execute();
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
    listCustomer.forEach((customer) {
      removeCustomer(customer);
    });
    selectedCustomer.clear();
    update();
  }

  addAll() {
    listCustomer.forEach((customer) {
      selectCustomer(customer);
    });
    update();
  }
}
