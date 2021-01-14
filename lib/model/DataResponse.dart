import 'package:posku/model/GoodReceived.dart';
import 'package:posku/model/GoodReceivedItem.dart';
import 'package:posku/model/Purchase.dart';
import 'package:posku/model/company.dart';
import 'package:posku/model/customer.dart';
import 'package:posku/model/customer_group.dart';
import 'package:posku/model/delivery.dart';
import 'package:posku/model/delivery_item.dart';
import 'package:posku/model/payment.dart';
import 'package:posku/model/price_group.dart';
import 'package:posku/model/product.dart';
import 'package:posku/model/purchase_items.dart';
import 'package:posku/model/sales_booking.dart';
import 'package:posku/model/sales_booking_item.dart';
import 'package:posku/model/user.dart';
import 'package:posku/model/warehouse.dart';
import 'package:posku/model/supplier.dart';

class DataResponse {
  int totalGoodsReceived;
  List<SalesBooking> listSalesBooking;
  Purchase purchase;
  List<Purchase> listPurchase;
  List<PurchaseItems> purchaseItems;
  List<SalesBookingItem> salesBookingItems;
  SalesBooking salesBooking;
  List<GoodReceived> listGoodsReceived;
  List<GoodReceivedItem> goodReceivedItems;
  GoodReceived goodReceived;
  Customer customer;
  Supplier supplier;
  Warehouse warehouse;
  List<Payment> listPayment;
  List<Delivery> listDelivery;
  Delivery delivery;
  List<DeliveryItem> deliveryItems;
  Company company;
  User user;
  String token;
  List<Customer> listCustomers;
  List<Supplier> listSupplier;
  List<CustomerGroup> customerGroups;
  List<PriceGroup> priceGroups;
  int totalCustomerData;
  List<Product> listGroupProductPrice;
  List<Warehouse> listWarehouses;
  List<Warehouse> listWarehousesSelected;
  List<Warehouse> listWarehousesDefault;
  List<Product> listProducts;
  List<Customer> customerSelected;

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
    listCustomers = ifExistList(json, 'list_customer', (obj) {
      return Customer.fromJson(obj);
    });
    customerSelected = ifExistList(json, 'customer_selected', (obj) {
      return Customer.fromJson(obj);
    });
    listProducts = ifExistList(json, 'list_products', (obj) {
      return Product.fromJson(obj);
    });
    listWarehouses = ifExistList(json, 'warehouses', (obj) {
      return Warehouse.fromJson(obj);
    });
    listWarehousesSelected = ifExistList(json, 'warehouses_selected', (obj) {
      return Warehouse.fromJson(obj);
    });
    listWarehousesDefault = ifExistList(json, 'warehouses_default', (obj) {
      return Warehouse.fromJson(obj);
    });
    listWarehouses = ifExistList(json, 'list_warehouses', (obj) {
      return Warehouse.fromJson(obj);
    }) ?? listWarehouses;

    listSupplier = ifExistList(json, 'list_suppliers', (obj) {
      return Supplier.fromJson(obj);
    }) ?? listSupplier;

    listGroupProductPrice = ifExistList(json, 'group_product_price', (obj) {
      return Product.fromJson(obj);
    });
    totalCustomerData = ifExist(json, 'total_customer_data');
    priceGroups = ifExistList(json, 'price_groups', (obj) {
      return PriceGroup.fromJson(obj);
    });
    customerGroups = ifExistList(json, 'customer_groups', (obj) {
      return CustomerGroup.fromJson(obj);
    });
    listCustomers = ifExistList(json, 'list_customers', (obj) {
      return Customer.fromJson(obj);
    }) ?? listCustomers;
    token = ifExist(json, 'token');
    company = ifExistObject(json, 'company', (obj) {
      return Company.fromJson(obj);
    });
    user = ifExistObject(json, 'user', (obj) {
      return User.fromJson(obj);
    });
    deliveryItems = ifExistList(json, 'delivery_items', (obj) {
      return DeliveryItem.fromJson(obj);
    });
    delivery = ifExistObject(json, 'delivery', (obj) {
      return Delivery.fromJson(obj);
    });
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
      return Supplier.fromJson(obj);
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

    purchase = ifExistObject(json, 'purchase', (sb) {
      return Purchase.fromJson(sb);
    });

    listPurchase = ifExistList(json, 'list_purchases', (purchase) {
      return Purchase.fromJson(purchase);
    });

    purchaseItems = ifExistList(json, 'purchase_items', (sb) {
      return PurchaseItems.fromJson(sb);
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
