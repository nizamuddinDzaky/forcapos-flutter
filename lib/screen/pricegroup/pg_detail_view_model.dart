import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posku/api/api_client.dart';
import 'package:posku/api/api_config.dart';
import 'package:posku/model/BaseResponse.dart';
import 'package:posku/model/price_group.dart';
import 'package:posku/model/product.dart';
import 'package:posku/screen/pricegroup/pg_detail_screen.dart';
import 'package:posku/util/my_number.dart';
import 'package:posku/util/resource/my_string.dart';

abstract class PGDetailViewModel extends State<PGDetailScreen> {
  bool isFirst = true;
  PriceGroup pg;
  List<Product> listProductPG;

  Future<Null> actionRefresh() async {
    var params = {
      MyString.KEY_ID_PRICE_GROUP: pg?.id,
    };
    var status = await ApiClient.methodGet(
      ApiConfig.urlProductPriceGroup,
      params: params,
      onBefore: (status) {},
      onSuccess: (data, flag) {
        var baseResponse = BaseResponse.fromJson(data);
        listProductPG = baseResponse?.data?.listGroupProductPrice;
      },
      onFailed: (title, message) {
        Get.defaultDialog(title: title, content: Text(message));
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text(message));
      },
      onAfter: (status) {
        setState(() {});
      },
    );
    setState(() {
      status.execute();
    });
    return null;
  }

  actionPutProductPrice(Product product) async {
    var params = {MyString.KEY_ID_PRICE_GROUP: pg?.id};
    Map<String, dynamic> body = {
      'product_id': product?.id,
      'price_credit': product?.priceKredit,
    };
    body.addAll(product?.toJson() ?? {});
    var status = await ApiClient.methodPut(
      ApiConfig.urlProductPriceGroupUpdate,
      body,
      params,
      onBefore: (status) {
        print('onbefore');
      },
      onSuccess: (data, _) {
        var product = Product.fromJson(data['data']);
        Get.defaultDialog(title: 'Update Berhasil', content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Harga: ${MyNumber.toNumberRpStr(product?.price)}'),
            Text('Harga Kredit: ${MyNumber.toNumberRpStr(product?.priceKredit)}'),
            Text('Pesanan Terkecil: ${MyNumber.toNumberIdStr(product?.minOrder)}'),
            Text('Kelipatan: ${product?.isMultiple == '1' ? 'Ya' : 'Tidak'}'),
          ],
        ));
      },
      onFailed: (title, message) {
        var baseResponse = BaseResponse.fromJson(jsonDecode(message));
        Get.defaultDialog(title: title, content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Kode error: ${baseResponse?.code}'),
          ],
        ));
      },
      onError: (title, message) {
        Get.defaultDialog(title: title, content: Text(message));
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
    if (Get.args(context) != null && isFirst) {
      var arg = Get.args(context) as Map<String, dynamic>;
      pg = PriceGroup.fromJson(arg);
      isFirst = false;
      actionRefresh();
    }
  }
}
