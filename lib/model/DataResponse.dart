import 'package:posku/model/GoodReceived.dart';
import 'package:posku/model/GoodReceivedItem.dart';
import 'package:posku/model/sales_booking.dart';

class DataResponse {
  int totalGoodsReceived;
  List<SalesBooking> listSalesBooking;
  List<GoodReceived> listGoodsReceived;
  List<GoodReceivedItem> goodReceivedItems;
  GoodReceived goodReceived;

  DataResponse(
      {this.totalGoodsReceived, this.listGoodsReceived, this.goodReceived, this.listSalesBooking});

  T ifExist<T>(json, key) {
    if (json[key] != null) {
      return json[key];
    }
    return null;
  }

  List<T> ifExistList<T>(json, key, Function fromJson) {
    if (json[key] != null) {
      var tempList = new List<T>();
      json[key].forEach((v) {
        tempList.add(fromJson(v));
      });
      return tempList;
    }
    return null;
  }

  DataResponse.fromJson(Map<String, dynamic> json) {
    listSalesBooking = ifExistList(json, 'list_sales_booking', (sb) {
      return SalesBooking.fromJson(sb);
    });
    totalGoodsReceived = ifExist(json, 'total_goods_received');
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
