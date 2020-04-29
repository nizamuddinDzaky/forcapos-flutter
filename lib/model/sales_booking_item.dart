class SalesBookingItem {
  String id;
  String saleId;
  String productId;
  String productCode;
  String productName;
  String productType;
  String optionId;
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
  String saleItemId;
  String productUnitId;
  String productUnitCode;
  String unitQuantity;
  String sentQuantity;
  String clientId;
  String flag;
  String isDeleted;
  String deviceId;
  String updatedAt;
  String uuid;
  String uuidApp;

  SalesBookingItem(
      {this.id,
        this.saleId,
        this.productId,
        this.productCode,
        this.productName,
        this.productType,
        this.optionId,
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
        this.saleItemId,
        this.productUnitId,
        this.productUnitCode,
        this.unitQuantity,
        this.sentQuantity,
        this.clientId,
        this.flag,
        this.isDeleted,
        this.deviceId,
        this.updatedAt,
        this.uuid,
        this.uuidApp});

  SalesBookingItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    saleId = json['sale_id'];
    productId = json['product_id'];
    productCode = json['product_code'];
    productName = json['product_name'];
    productType = json['product_type'];
    optionId = json['option_id'];
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
    saleItemId = json['sale_item_id'];
    productUnitId = json['product_unit_id'];
    productUnitCode = json['product_unit_code'];
    unitQuantity = json['unit_quantity'];
    sentQuantity = json['sent_quantity'];
    clientId = json['client_id'];
    flag = json['flag'];
    isDeleted = json['is_deleted'];
    deviceId = json['device_id'];
    updatedAt = json['updated_at'];
    uuid = json['uuid'];
    uuidApp = json['uuid_app'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sale_id'] = this.saleId;
    data['product_id'] = this.productId;
    data['product_code'] = this.productCode;
    data['product_name'] = this.productName;
    data['product_type'] = this.productType;
    data['option_id'] = this.optionId;
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
    data['sale_item_id'] = this.saleItemId;
    data['product_unit_id'] = this.productUnitId;
    data['product_unit_code'] = this.productUnitCode;
    data['unit_quantity'] = this.unitQuantity;
    data['sent_quantity'] = this.sentQuantity;
    data['client_id'] = this.clientId;
    data['flag'] = this.flag;
    data['is_deleted'] = this.isDeleted;
    data['device_id'] = this.deviceId;
    data['updated_at'] = this.updatedAt;
    data['uuid'] = this.uuid;
    data['uuid_app'] = this.uuidApp;
    return data;
  }
}