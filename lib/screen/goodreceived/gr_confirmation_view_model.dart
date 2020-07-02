import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/helper/custom_dialog.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/GoodReceived.dart';
import 'package:posku/model/warehouse.dart';
import 'package:posku/screen/goodreceived/gr_confirmation_screen.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class GRConfirmationViewModel extends State<GRConfirmationScreen> {
  final priceController = TextEditingController();
  final qtyController = TextEditingController();
  var total = 0.0;
  GoodReceived gr;
  bool isFirst = true;
  List<Warehouse> listWarehouse = [];
  Warehouse currentWarehouse;

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

  void showWarehousePicker(buildContext) {
    DataPicker.showDatePicker(
      buildContext,
      locale: 'id',
      datas: listWarehouse,
      title: 'Pilih Gudang',
      onConfirm: (data) {
        currentWarehouse = data;
        setState(() {});
      },
    );
  }

  actionGRtoPO(body, params) async {
    var status = await ApiClient.methodPost(
        ApiConfig.urlAddGRtoPO, body, params, onBefore: (status) {
      print('onbefore');
    }, onSuccess: (data, _) {
      Get.snackbar('GR No SPJ: ${gr.noSpj}', 'Status: Berhasil di terima');
      gr.statusPenerimaan = 'received';
      Get.back(result: gr.toJson());
    }, onFailed: (title, message) {
//      gr.statusPenerimaan = 'received';
//      Get.back(result: gr.toJson());
      CustomDialog.showAlertDialog(context,
          title: 'Gagal',
          message: message,
          leftAction: CustomDialog.customAction());
    }, onError: (title, message) {
      print('onerror');
    }, onAfter: (status) {
      print('onafter');
    });
    status.execute();
  }

  actionBtnReceive() async {
    if (null == currentWarehouse?.id) {
      CustomDialog.showAlertDialog(
        context,
        message: 'Wajib Pilih Gudang',
        leftAction: CustomDialog.customAction(),
      );
      return;
    }
    var price = MyNumber.strIDToDouble(priceController.text);
    var body = {
      MyString.KEY_GR_PRICE: price.toString(),
      'warehouse_id': currentWarehouse?.id,
    };
    var params = {
      MyString.KEY_ID_GOODS_RECEIVED: gr.id,
    };
    print('add GR $price $body $params');
    await actionGRtoPO(body, params);
  }

  void totalPrice() {
    var price = MyNumber.strIDToDouble(priceController.text);
    var qty = MyNumber.strIDToDouble(qtyController.text);
    setState(() {
      total = price * qty;
    });
  }

  @override
  void initState() {
    super.initState();
    priceController.addListener(totalPrice);
    qtyController.addListener(totalPrice);
    //WidgetsBinding.instance.addPostFrameCallback((_) => totalPrice());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.arguments != null && isFirst) {
      var arg = Get.arguments as Map<String, dynamic>;
      gr = GoodReceived.fromJson(arg ?? {});
      var qtyDo = MyNumber.strUSToDouble(gr.qtyDo);
      var total = MyNumber.strUSToDouble(gr.total);
      var price = total / (qtyDo == 0 ? 1 : qtyDo);
//      print('cek count ${gr.qtyDo} ${gr.total} | $total / $qtyDo = $price');
      priceController.text = MyNumber.toNumberId(price);
      qtyController.text = MyNumber.toNumberId(double.tryParse(gr.qtyDo));
      isFirst = false;
      actionGetWarehouse();
//      print('cek gr $price ${gr.total} ${Get.arguments}');
    }
  }

  @override
  void dispose() {
    priceController.dispose();
    qtyController.dispose();
    super.dispose();
  }
}
