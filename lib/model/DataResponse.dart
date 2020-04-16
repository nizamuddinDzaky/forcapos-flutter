import 'package:posku/model/GoodReceived.dart';

class DataResponse {
  int totalGoodsReceived;
  List<GoodReceived> listGoodsReceived;

  DataResponse({this.totalGoodsReceived, this.listGoodsReceived});

  DataResponse.fromJson(Map<String, dynamic> json) {
    totalGoodsReceived = json['total_goods_received'];
    if (json['list_goods_received'] != null) {
      listGoodsReceived = new List<GoodReceived>();
      json['list_goods_received'].forEach((v) {
        listGoodsReceived.add(new GoodReceived.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_goods_received'] = this.totalGoodsReceived;
    if (this.listGoodsReceived != null) {
      data['list_goods_received'] =
          this.listGoodsReceived.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
