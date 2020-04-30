import 'package:posku/model/GoodReceived.dart';
import 'package:posku/model/GoodReceivedItem.dart';
import 'package:posku/model/company.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/delivery.dart';
import 'package:posku/model/payment.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/model/sales_booking_item.dart';
import 'package:posku/model/warehouse.dart';

class DataResponse {
  int totalGoodsReceived;
  List<SalesBooking> listSalesBooking;
  List<SalesBookingItem> salesBookingItems;
  SalesBooking salesBooking;
  List<GoodReceived> listGoodsReceived;
  List<GoodReceivedItem> goodReceivedItems;
  GoodReceived goodReceived;
  Customer customer;
  Company supplier;
  Warehouse warehouse;
  List<Payment> listPayment;
  List<Delivery> listDelivery;

  DataResponse(
      {this.totalGoodsReceived, this.listGoodsReceived, this.goodReceived, this.listSalesBooking});

  T ifExist<T>(json, key) {
    if (json[key] != null) {
      return json[key];
    }
    return null;
  }

  T ifExistObject<T>(json, key, Function fromJson) {
    if (json[key] != null) {
      return fromJson(json[key]);
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
    listDelivery = ifExistList(json, 'list_deliveries_booking', (obj) {
      return Delivery.fromJson(obj);
    });
    listPayment = ifExistList(json, 'list_payments', (obj) {
      return Payment.fromJson(obj);
    });
    customer = ifExistObject(json, 'customer', (obj) {
      return Customer.fromJson(obj);
    });
    warehouse = ifExistObject(json, 'detail_warehouses', (obj) {
      return Warehouse.fromJson(obj);
    });
    supplier = ifExistObject(json, 'supplier', (obj) {
      return Company.fromJson(obj);
    });
    salesBooking = ifExistObject(json, 'sale', (sb) {
      return SalesBooking.fromJson(sb);
    });
    listSalesBooking = ifExistList(json, 'list_sales_booking', (sb) {
      return SalesBooking.fromJson(sb);
    });
    salesBookingItems = ifExistList(json, 'sale_items', (sb) {
      return SalesBookingItem.fromJson(sb);
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
