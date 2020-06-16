class DeliveryItem {
  String id;
  String deliveryId;
  String saleId;
  String productId;
  String productCode;
  String productName;
  String productType;
  String quantityOrdered;
  String quantitySent;
  String goodQuantity;
  String badQuantity;
  String productUnitId;
  String productUnitCode;
  String clientId;
  String flag;
  String isDeleted;
  String deviceId;
  String uuid;
  String uuidApp;
  String createdAt;
  String updatedAt;
  String deliveryItemsId;
  String allSentQty;
  String warehouseId;
  String tempQty;

  DeliveryItem(
      {this.id,
        this.deliveryId,
        this.saleId,
        this.productId,
        this.productCode,
        this.productName,
        this.productType,
        this.quantityOrdered,
        this.quantitySent,
        this.goodQuantity,
        this.badQuantity,
        this.productUnitId,
        this.productUnitCode,
        this.clientId,
        this.flag,
        this.isDeleted,
        this.deviceId,
        this.uuid,
        this.uuidApp,
        this.createdAt,
        this.updatedAt,
        this.deliveryItemsId,
        this.allSentQty,
        this.warehouseId});

  DeliveryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryId = json['delivery_id'];
    saleId = json['sale_id'];
    productId = json['product_id'];
    productCode = json['product_code'];
    productName = json['product_name'];
    productType = json['product_type'];
    quantityOrdered = json['quantity_ordered'];
    quantitySent = json['quantity_sent'];
    goodQuantity = json['good_quantity'];
    badQuantity = json['bad_quantity'];
    productUnitId = json['product_unit_id'];
    productUnitCode = json['product_unit_code'];
    clientId = json['client_id'];
    flag = json['flag'];
    isDeleted = json['is_deleted'];
    deviceId = json['device_id'];
    uuid = json['uuid'];
    uuidApp = json['uuid_app'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryItemsId = json['delivery_items_id'];
    allSentQty = json['all_sent_qty'];
    warehouseId = json['warehouse_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['delivery_id'] = this.deliveryId;
    data['sale_id'] = this.saleId;
    data['product_id'] = this.productId;
    data['product_code'] = this.productCode;
    data['product_name'] = this.productName;
    data['product_type'] = this.productType;
    data['quantity_ordered'] = this.quantityOrdered;
    data['quantity_sent'] = this.quantitySent;
    data['good_quantity'] = this.goodQuantity;
    data['bad_quantity'] = this.badQuantity;
    data['product_unit_id'] = this.productUnitId;
    data['product_unit_code'] = this.productUnitCode;
    data['client_id'] = this.clientId;
    data['flag'] = this.flag;
    data['is_deleted'] = this.isDeleted;
    data['device_id'] = this.deviceId;
    data['uuid'] = this.uuid;
    data['uuid_app'] = this.uuidApp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['delivery_items_id'] = this.deliveryItemsId;
    data['all_sent_qty'] = this.allSentQty;
    data['warehouse_id'] = this.warehouseId;
    return data;
  }
}
