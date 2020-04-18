import 'package:posku/model/GoodReceived.dart';
import 'package:posku/model/GoodReceivedItem.dart';

class DataResponse {
  int totalGoodsReceived;
  List<GoodReceived> listGoodsReceived;
  List<GoodReceivedItem> goodReceivedItems;
  GoodReceived goodReceived;

  DataResponse(
      {this.totalGoodsReceived, this.listGoodsReceived, this.goodReceived});

  DataResponse.fromJson(Map<String, dynamic> json) {
    totalGoodsReceived = json['total_goods_received'];
    if (json['list_goods_received'] != null) {
      listGoodsReceived = new List<GoodReceived>();
      json['list_goods_received'].forEach((v) {
        listGoodsReceived.add(new GoodReceived.fromJson(v));
      });
    }
    if (json['good_received_items'] != null) {
      goodReceivedItems = new List<GoodReceivedItem>();
      json['good_received_items'].forEach((v) {
        goodReceivedItems.add(new GoodReceivedItem.fromJson(v));
      });
    }
    if (json['good_received'] != null) {
      goodReceived = GoodReceived.fromJson(json['good_received']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_goods_received'] = this.totalGoodsReceived;
    data['good_received'] = this.goodReceived;
    if (this.goodReceivedItems != null) {
      data['good_received_items'] =
          this.goodReceivedItems.map((v) => v.toJson()).toList();
    }
    if (this.listGoodsReceived != null) {
      data['list_goods_received'] =
          this.listGoodsReceived.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
