import 'package:get/get.dart';

class MasterDataController extends GetController {
  static MasterDataController get to => Get.find();

  bool isRefresh = false;

  refresh({Function callback}) {
    if (callback != null && isRefresh) {
      callback();
      isRefresh = false;
    }
    update();
  }
}