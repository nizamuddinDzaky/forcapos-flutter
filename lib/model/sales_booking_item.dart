class SalesBookingItem {
  String id;
  String deliveriesSmigId;
  String productId;
  String productCode;
  String productName;
  String productType;
  String netUnitPrice;
  String unitPrice;
  String quantity;
  String warehouseId;
  String itemTax;
  String taxRateId;
  String tax;
  String discount;
  String itemDiscount;
  String subtotal;
  String serialNo;
  String realUnitPrice;
  String productUnitId;
  String productUnitCode;
  String unitQuantity;
  String clientId;
  String flag;
  String isDeleted;
  String deviceId;
  String uuid;
  String uuidApp;

  SalesBookingItem(
      {this.id,
      this.deliveriesSmigId,
      this.productId,
      this.productCode,
      this.productName,
      this.productType,
      this.netUnitPrice,
      this.unitPrice,
      this.quantity,
      this.warehouseId,
      this.itemTax,
      this.taxRateId,
      this.tax,
      this.discount,
      this.itemDiscount,
      this.subtotal,
      this.serialNo,
      this.realUnitPrice,
      this.productUnitId,
      this.productUnitCode,
      this.unitQuantity,
      this.clientId,
      this.flag,
      this.isDeleted,
      this.deviceId,
      this.uuid,
      this.uuidApp});

  SalesBookingItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveriesSmigId = json['deliveries_smig_id'];
    productId = json['product_id'];
    productCode = json['product_code'];
    productName = json['product_name'];
    productType = json['product_type'];
    netUnitPrice = json['net_unit_price'];
    unitPrice = json['unit_price'];
    quantity = json['quantity'];
    warehouseId = json['warehouse_id'];
    itemTax = json['item_tax'];
    taxRateId = json['tax_rate_id'];
    tax = json['tax'];
    discount = json['discount'];
    itemDiscount = json['item_discount'];
    subtotal = json['subtotal'];
    serialNo = json['serial_no'];
    realUnitPrice = json['real_unit_price'];
    productUnitId = json['product_unit_id'];
    productUnitCode = json['product_unit_code'];
    unitQuantity = json['unit_quantity'];
    clientId = json['client_id'];
    flag = json['flag'];
    isDeleted = json['is_deleted'];
    deviceId = json['device_id'];
    uuid = json['uuid'];
    uuidApp = json['uuid_app'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deliveries_smig_id'] = this.deliveriesSmigId;
    data['product_id'] = this.productId;
    data['product_code'] = this.productCode;
    data['product_name'] = this.productName;
    data['product_type'] = this.productType;
    data['net_unit_price'] = this.netUnitPrice;
    data['unit_price'] = this.unitPrice;
    data['quantity'] = this.quantity;
    data['warehouse_id'] = this.warehouseId;
    data['item_tax'] = this.itemTax;
    data['tax_rate_id'] = this.taxRateId;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['item_discount'] = this.itemDiscount;
    data['subtotal'] = this.subtotal;
    data['serial_no'] = this.serialNo;
    data['real_unit_price'] = this.realUnitPrice;
    data['product_unit_id'] = this.productUnitId;
    data['product_unit_code'] = this.productUnitCode;
    data['unit_quantity'] = this.unitQuantity;
    data['client_id'] = this.clientId;
    data['flag'] = this.flag;
    data['is_deleted'] = this.isDeleted;
    data['device_id'] = this.deviceId;
    data['uuid'] = this.uuid;
    data['uuid_app'] = this.uuidApp;
    return data;
  }
}
