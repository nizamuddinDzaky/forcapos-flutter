import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_cupertino_page_route.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/GoodReceived.dart';
import 'package:posku/model/GoodReceivedItem.dart';
import 'package:posku/screen/goodreceived/gr_detail_screen.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class GRDetailViewModel extends State<GRDetailScreen> {
  bool isFirst = true;
  String idGr;
  GoodReceived gr;
  GoodReceived newGr;
  List<GoodReceivedItem> grItems = [];

  actionCopy(String text) async {
    if (text != null) {
      Clipboard.setData(ClipboardData(text: text));
      Get.snackbar('Berhasil disalin', text);
      /*CustomDialog.showAlertDialog(
        context,
        title: 'Berhasil disalin',
        message: text,
      );*/
    }
  }

  actionGetDetailGR() async {
    var params = {
      MyString.KEY_ID_GOODS_RECEIVED: idGr,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlDetailGoodReceived,
      params: params,
      onBefore: (status) {
        print('onbefore');
      },
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        setState(() {
          gr = baseResponse.data.goodReceived;
          grItems = baseResponse.data.goodReceivedItems;
        });
        print('onsuccess');
      },
      onFailed: (title, message) {
        print('onfailed');
      },
      onError: (title, message) {
        print('onerror');
      },
      onAfter: (status) {
        print('onafter');
      },
    );
    status.execute();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.arguments != null && isFirst) {
      var arg = Get.arguments as Map<String, dynamic>;
      gr = GoodReceived.fromJson(arg ?? {});
      idGr = gr.id;
      actionGetDetailGR();
      isFirst = false;
    }
    (ModalRoute.of(context) as CustomCupertinoPageRoute)?.resultPop =
        newGr?.toJson();
  }
}
