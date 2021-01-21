class PurchaseItems {
  String id;
  String purchaseId;
  Null transferId;
  String productId;
  String productCode;
  String productName;
  String optionId;
  String netUnitCost;
  String quantity;
  String warehouseId;
  String itemTax;
  String taxRateId;
  String tax;
  String discount;
  String itemDiscount;
  Null expiry;
  String subtotal;
  String quantityBalance;
  String date;
  String status;
  String unitCost;
  String realUnitCost;
  String quantityReceived;
  String quantityReturn;
  Null supplierPartNo;
  String purchaseItemId;
  String productUnitId;
  String productUnitCode;
  String unitQuantity;
  String goodQuantity;
  String badQuantity;
  Null clientId;
  Null flag;
  Null isDeleted;
  Null deviceId;
  Null uuid;
  Null uuidApp;
  Null taxCode;
  Null taxName;
  Null taxRate;
  String unit;
  String details;
  Null variant;

  PurchaseItems(
      {this.id,
        this.purchaseId,
        this.transferId,
        this.productId,
        this.productCode,
        this.productName,
        this.optionId,
        this.netUnitCost,
        this.quantity,
        this.warehouseId,
        this.itemTax,
        this.taxRateId,
        this.tax,
        this.discount,
        this.itemDiscount,
        this.expiry,
        this.subtotal,
        this.quantityBalance,
        this.date,
        this.status,
        this.unitCost,
        this.realUnitCost,
        this.quantityReceived,
        this.supplierPartNo,
        this.purchaseItemId,
        this.productUnitId,
        this.productUnitCode,
        this.unitQuantity,
        this.goodQuantity,
        this.badQuantity,
        this.clientId,
        this.flag,
        this.isDeleted,
        this.deviceId,
        this.uuid,
        this.uuidApp,
        this.taxCode,
        this.taxName,
        this.taxRate,
        this.unit,
        this.details,
        this.variant});

  PurchaseItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purchaseId = json['purchase_id'];
    transferId = json['transfer_id'];
    productId = json['product_id'];
    productCode = json['product_code'];
    productName = json['product_name'];
    optionId = json['option_id'];
    netUnitCost = json['net_unit_cost'];
    quantity = json['quantity'];
    warehouseId = json['warehouse_id'];
    itemTax = json['item_tax'];
    taxRateId = json['tax_rate_id'];
    tax = json['tax'];
    discount = json['discount'];
    itemDiscount = json['item_discount'];
    expiry = json['expiry'];
    subtotal = json['subtotal'];
    quantityBalance = json['quantity_balance'];
    date = json['date'];
    status = json['status'];
    unitCost = json['unit_cost'];
    realUnitCost = json['real_unit_cost'];
    quantityReceived = json['quantity_received'];
    supplierPartNo = json['supplier_part_no'];
    purchaseItemId = json['purchase_item_id'];
    productUnitId = json['product_unit_id'];
    productUnitCode = json['product_unit_code'];
    unitQuantity = json['unit_quantity'];
    goodQuantity = json['good_quantity'];
    badQuantity = json['bad_quantity'];
    clientId = json['client_id'];
    flag = json['flag'];
    isDeleted = json['is_deleted'];
    deviceId = json['device_id'];
    uuid = json['uuid'];
    uuidApp = json['uuid_app'];
    taxCode = json['tax_code'];
    taxName = json['tax_name'];
    taxRate = json['tax_rate'];
    unit = json['unit'];
    details = json['details'];
    variant = json['variant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['purchase_id'] = this.purchaseId;
    data['transfer_id'] = this.transferId;
    data['product_id'] = this.productId;
    data['product_code'] = this.productCode;
    data['product_name'] = this.productName;
    data['option_id'] = this.optionId;
    data['net_unit_cost'] = this.netUnitCost;
    data['quantity'] = this.quantity;
    data['warehouse_id'] = this.warehouseId;
    data['item_tax'] = this.itemTax;
    data['tax_rate_id'] = this.taxRateId;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['item_discount'] = this.itemDiscount;
    data['expiry'] = this.expiry;
    data['subtotal'] = this.subtotal;
    data['quantity_balance'] = this.quantityBalance;
    data['date'] = this.date;
    data['status'] = this.status;
    data['unit_cost'] = this.unitCost;
    data['real_unit_cost'] = this.realUnitCost;
    data['quantity_received'] = this.quantityReceived;
    data['supplier_part_no'] = this.supplierPartNo;
    data['purchase_item_id'] = this.purchaseItemId;
    data['product_unit_id'] = this.productUnitId;
    data['product_unit_code'] = this.productUnitCode;
    data['unit_quantity'] = this.unitQuantity;
    data['good_quantity'] = this.goodQuantity;
    data['bad_quantity'] = this.badQuantity;
    data['client_id'] = this.clientId;
    data['flag'] = this.flag;
    data['is_deleted'] = this.isDeleted;
    data['device_id'] = this.deviceId;
    data['uuid'] = this.uuid;
    data['uuid_app'] = this.uuidApp;
    data['tax_code'] = this.taxCode;
    data['tax_name'] = this.taxName;
    data['tax_rate'] = this.taxRate;
    data['unit'] = this.unit;
    data['details'] = this.details;
    data['variant'] = this.variant;
    return data;
  }
}
