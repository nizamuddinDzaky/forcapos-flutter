class SalesBooking {
  String id;
  String date;
  String referenceNo;
  String customerId;
  String customer;
  String billerId;
  String biller;
  String warehouseId;
  String note;
  String staffNote;
  String total;
  String productDiscount;
  String totalDiscount;
  String orderDiscountId;
  String orderDiscount;
  String productTax;
  String orderTaxId;
  String orderTax;
  String totalTax;
  String shipping;
  String grandTotal;
  String saleStatus;
  String paymentStatus;
  String paymentTerm;
  String saleType;
  String dueDate;
  String createdBy;
  String createdAt;
  String updatedBy;
  String updatedAt;
  String totalItems;
  String pos;
  String paid;
  String returnId;
  String surcharge;
  String attachment;
  String returnSaleRef;
  String saleId;
  String returnSaleTotal;
  String rounding;
  String clientId;
  String flag;
  String isDeleted;
  String deviceId;
  String uuid;
  String uuidApp;
  String orderId;
  String mtid;
  String companyId;
  String deliveryDate;
  String isUpdatedPrice;
  String cf1;
  String cf2;
  String charge;
  String reason;
  String correctionPrice;
  String deliveryMethod;
  String paymentMethod;
  String statusKreditPro;
  String deliveryStatus;

  SalesBooking(
      {this.id,
        this.date,
        this.referenceNo,
        this.customerId,
        this.customer,
        this.billerId,
        this.biller,
        this.warehouseId,
        this.note,
        this.staffNote,
        this.total,
        this.productDiscount,
        this.totalDiscount,
        this.orderDiscountId,
        this.orderDiscount,
        this.productTax,
        this.orderTaxId,
        this.orderTax,
        this.totalTax,
        this.shipping,
        this.grandTotal,
        this.saleStatus,
        this.paymentStatus,
        this.paymentTerm,
        this.saleType,
        this.dueDate,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt,
        this.totalItems,
        this.pos,
        this.paid,
        this.returnId,
        this.surcharge,
        this.attachment,
        this.returnSaleRef,
        this.saleId,
        this.returnSaleTotal,
        this.rounding,
        this.clientId,
        this.flag,
        this.isDeleted,
        this.deviceId,
        this.uuid,
        this.uuidApp,
        this.orderId,
        this.mtid,
        this.companyId,
        this.deliveryDate,
        this.isUpdatedPrice,
        this.cf1,
        this.cf2,
        this.charge,
        this.reason,
        this.correctionPrice,
        this.deliveryMethod,
        this.paymentMethod,
        this.statusKreditPro,
        this.deliveryStatus});

  SalesBooking.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    date = json['date'];
    referenceNo = json['reference_no'];
    customerId = json['customer_id'];
    customer = json['customer'];
    billerId = json['biller_id'];
    biller = json['biller'];
    warehouseId = json['warehouse_id'];
    note = json['note'];
    staffNote = json['staff_note'];
    total = json['total'];
    productDiscount = json['product_discount'];
    totalDiscount = json['total_discount'];
    orderDiscountId = json['order_discount_id'];
    orderDiscount = json['order_discount'];
    productTax = json['product_tax'];
    orderTaxId = json['order_tax_id'];
    orderTax = json['order_tax'];
    totalTax = json['total_tax'];
    shipping = json['shipping'];
    grandTotal = json['grand_total'];
    saleStatus = json['sale_status'];
    paymentStatus = json['payment_status'];
    paymentTerm = json['payment_term'];
    saleType = json['sale_type'];
    dueDate = json['due_date'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    totalItems = json['total_items'];
    pos = json['pos'];
    paid = json['paid'];
    returnId = json['return_id'];
    surcharge = json['surcharge'];
    attachment = json['attachment'];
    returnSaleRef = json['return_sale_ref'];
    saleId = json['sale_id'];
    returnSaleTotal = json['return_sale_total'];
    rounding = json['rounding'];
    clientId = json['client_id'];
    flag = json['flag'];
    isDeleted = json['is_deleted'];
    deviceId = json['device_id'];
    uuid = json['uuid'];
    uuidApp = json['uuid_app'];
    orderId = json['order_id'];
    mtid = json['mtid'];
    companyId = json['company_id'];
    deliveryDate = json['delivery_date'];
    isUpdatedPrice = json['is_updated_price'];
    cf1 = json['cf1'];
    cf2 = json['cf2'];
    charge = json['charge'];
    reason = json['reason'];
    correctionPrice = json['correction_price'];
    deliveryMethod = json['delivery_method'];
    paymentMethod = json['payment_method'];
    statusKreditPro = json['status_kredit_pro'];
    deliveryStatus = json['delivery_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['reference_no'] = this.referenceNo;
    data['customer_id'] = this.customerId;
    data['customer'] = this.customer;
    data['biller_id'] = this.billerId;
    data['biller'] = this.biller;
    data['warehouse_id'] = this.warehouseId;
    data['note'] = this.note;
    data['staff_note'] = this.staffNote;
    data['total'] = this.total;
    data['product_discount'] = this.productDiscount;
    data['total_discount'] = this.totalDiscount;
    data['order_discount_id'] = this.orderDiscountId;
    data['order_discount'] = this.orderDiscount;
    data['product_tax'] = this.productTax;
    data['order_tax_id'] = this.orderTaxId;
    data['order_tax'] = this.orderTax;
    data['total_tax'] = this.totalTax;
    data['shipping'] = this.shipping;
    data['grand_total'] = this.grandTotal;
    data['sale_status'] = this.saleStatus;
    data['payment_status'] = this.paymentStatus;
    data['payment_term'] = this.paymentTerm;
    data['sale_type'] = this.saleType;
    data['due_date'] = this.dueDate;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['total_items'] = this.totalItems;
    data['pos'] = this.pos;
    data['paid'] = this.paid;
    data['return_id'] = this.returnId;
    data['surcharge'] = this.surcharge;
    data['attachment'] = this.attachment;
    data['return_sale_ref'] = this.returnSaleRef;
    data['sale_id'] = this.saleId;
    data['return_sale_total'] = this.returnSaleTotal;
    data['rounding'] = this.rounding;
    data['client_id'] = this.clientId;
    data['flag'] = this.flag;
    data['is_deleted'] = this.isDeleted;
    data['device_id'] = this.deviceId;
    data['uuid'] = this.uuid;
    data['uuid_app'] = this.uuidApp;
    data['order_id'] = this.orderId;
    data['mtid'] = this.mtid;
    data['company_id'] = this.companyId;
    data['delivery_date'] = this.deliveryDate;
    data['is_updated_price'] = this.isUpdatedPrice;
    data['cf1'] = this.cf1;
    data['cf2'] = this.cf2;
    data['charge'] = this.charge;
    data['reason'] = this.reason;
    data['correction_price'] = this.correctionPrice;
    data['delivery_method'] = this.deliveryMethod;
    data['payment_method'] = this.paymentMethod;
    data['status_kredit_pro'] = this.statusKreditPro;
    data['delivery_status'] = this.deliveryStatus;
    return data;
  }
}