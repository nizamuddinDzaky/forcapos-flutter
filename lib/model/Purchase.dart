class Purchase {
  String id;
  String referenceNo;
  String date;
  String supplierId;
  String supplier;
  String warehouseId;
  String note;
  String total;
  String productDiscount;
  String orderDiscountId;
  String orderDiscount;
  String totalDiscount;
  String productTax;
  String orderTaxId;
  String orderTax;
  String totalTax;
  String shipping;
  String grandTotal;
  String paid;
  String status;
  String paymentStatus;
  String createdBy;
  String createdAt;
  String updatedBy;
  String updatedAt;
  String attachment;
  String paymentTerm;
  String dueDate;
  String returnId;
  String surcharge;
  String returnPurchaseRef;
  String purchaseId;
  String returnPurchaseTotal;
  String clientId;
  String flag;
  String isDeleted;
  String deviceId;
  String uuid;
  String uuidApp;
  String companyId;
  String companyHeadId;
  String sinoSpj;
  String sinoDo;
  String sinoSo;
  String sinoBilling;
  String shippingBy;
  String shippingDate;
  String receiver;
  String isWatched;
  String cf1;
  String cf2;
  String bankId;
  String paymentMethod;
  String paymentType;
  String paymentDeadline;
  String paymentDuration;
  String charge;
  String chargeThirdParty;
  String thirdPartySentAt;
  String correctionPrice;
  String deliveryMethod;
  String licensePlate;
  String createdDevice;
  String updatedDevice;

  Purchase(
      {this.id,
        this.referenceNo,
        this.date,
        this.supplierId,
        this.supplier,
        this.warehouseId,
        this.note,
        this.total,
        this.productDiscount,
        this.orderDiscountId,
        this.orderDiscount,
        this.totalDiscount,
        this.productTax,
        this.orderTaxId,
        this.orderTax,
        this.totalTax,
        this.shipping,
        this.grandTotal,
        this.paid,
        this.status,
        this.paymentStatus,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt,
        this.attachment,
        this.paymentTerm,
        this.dueDate,
        this.returnId,
        this.surcharge,
        this.returnPurchaseRef,
        this.purchaseId,
        this.returnPurchaseTotal,
        this.clientId,
        this.flag,
        this.isDeleted,
        this.deviceId,
        this.uuid,
        this.uuidApp,
        this.companyId,
        this.companyHeadId,
        this.sinoSpj,
        this.sinoDo,
        this.sinoSo,
        this.sinoBilling,
        this.shippingBy,
        this.shippingDate,
        this.receiver,
        this.isWatched,
        this.cf1,
        this.cf2,
        this.bankId,
        this.paymentMethod,
        this.paymentType,
        this.paymentDeadline,
        this.paymentDuration,
        this.charge,
        this.chargeThirdParty,
        this.thirdPartySentAt,
        this.correctionPrice,
        this.deliveryMethod,
        this.licensePlate,
        this.createdDevice,
        this.updatedDevice});

  Purchase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceNo = json['reference_no'];
    date = json['date'];
    supplierId = json['supplier_id'];
    supplier = json['supplier'];
    warehouseId = json['warehouse_id'];
    note = json['note'];
    total = json['total'];
    productDiscount = json['product_discount'];
    orderDiscountId = json['order_discount_id'];
    orderDiscount = json['order_discount'];
    totalDiscount = json['total_discount'];
    productTax = json['product_tax'];
    orderTaxId = json['order_tax_id'];
    orderTax = json['order_tax'];
    totalTax = json['total_tax'];
    shipping = json['shipping'];
    grandTotal = json['grand_total'];
    paid = json['paid'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    attachment = json['attachment'];
    paymentTerm = json['payment_term'];
    dueDate = json['due_date'];
    returnId = json['return_id'];
    surcharge = json['surcharge'];
    returnPurchaseRef = json['return_purchase_ref'];
    purchaseId = json['purchase_id'];
    returnPurchaseTotal = json['return_purchase_total'];
    clientId = json['client_id'];
    flag = json['flag'];
    isDeleted = json['is_deleted'];
    deviceId = json['device_id'];
    uuid = json['uuid'];
    uuidApp = json['uuid_app'];
    companyId = json['company_id'];
    companyHeadId = json['company_head_id'];
    sinoSpj = json['sino_spj'];
    sinoDo = json['sino_do'];
    sinoSo = json['sino_so'];
    sinoBilling = json['sino_billing'];
    shippingBy = json['shipping_by'];
    shippingDate = json['shipping_date'];
    receiver = json['receiver'];
    isWatched = json['is_watched'];
    cf1 = json['cf1'];
    cf2 = json['cf2'];
    bankId = json['bank_id'];
    paymentMethod = json['payment_method'];
    paymentType = json['payment_type'];
    paymentDeadline = json['payment_deadline'];
    paymentDuration = json['payment_duration'];
    charge = json['charge'];
    chargeThirdParty = json['charge_third_party'];
    thirdPartySentAt = json['third_party_sent_at'];
    correctionPrice = json['correction_price'];
    deliveryMethod = json['delivery_method'];
    licensePlate = json['license_plate'];
    createdDevice = json['created_device'];
    updatedDevice = json['updated_device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_no'] = this.referenceNo;
    data['date'] = this.date;
    data['supplier_id'] = this.supplierId;
    data['supplier'] = this.supplier;
    data['warehouse_id'] = this.warehouseId;
    data['note'] = this.note;
    data['total'] = this.total;
    data['product_discount'] = this.productDiscount;
    data['order_discount_id'] = this.orderDiscountId;
    data['order_discount'] = this.orderDiscount;
    data['total_discount'] = this.totalDiscount;
    data['product_tax'] = this.productTax;
    data['order_tax_id'] = this.orderTaxId;
    data['order_tax'] = this.orderTax;
    data['total_tax'] = this.totalTax;
    data['shipping'] = this.shipping;
    data['grand_total'] = this.grandTotal;
    data['paid'] = this.paid;
    data['status'] = this.status;
    data['payment_status'] = this.paymentStatus;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['attachment'] = this.attachment;
    data['payment_term'] = this.paymentTerm;
    data['due_date'] = this.dueDate;
    data['return_id'] = this.returnId;
    data['surcharge'] = this.surcharge;
    data['return_purchase_ref'] = this.returnPurchaseRef;
    data['purchase_id'] = this.purchaseId;
    data['return_purchase_total'] = this.returnPurchaseTotal;
    data['client_id'] = this.clientId;
    data['flag'] = this.flag;
    data['is_deleted'] = this.isDeleted;
    data['device_id'] = this.deviceId;
    data['uuid'] = this.uuid;
    data['uuid_app'] = this.uuidApp;
    data['company_id'] = this.companyId;
    data['company_head_id'] = this.companyHeadId;
    data['sino_spj'] = this.sinoSpj;
    data['sino_do'] = this.sinoDo;
    data['sino_so'] = this.sinoSo;
    data['sino_billing'] = this.sinoBilling;
    data['shipping_by'] = this.shippingBy;
    data['shipping_date'] = this.shippingDate;
    data['receiver'] = this.receiver;
    data['is_watched'] = this.isWatched;
    data['cf1'] = this.cf1;
    data['cf2'] = this.cf2;
    data['bank_id'] = this.bankId;
    data['payment_method'] = this.paymentMethod;
    data['payment_type'] = this.paymentType;
    data['payment_deadline'] = this.paymentDeadline;
    data['payment_duration'] = this.paymentDuration;
    data['charge'] = this.charge;
    data['charge_third_party'] = this.chargeThirdParty;
    data['third_party_sent_at'] = this.thirdPartySentAt;
    data['correction_price'] = this.correctionPrice;
    data['delivery_method'] = this.deliveryMethod;
    data['license_plate'] = this.licensePlate;
    data['created_device'] = this.createdDevice;
    data['updated_device'] = this.updatedDevice;
    return data;
  }
}