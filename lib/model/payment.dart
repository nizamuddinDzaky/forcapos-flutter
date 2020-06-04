class Payment {
  String id;
  String date;
  String saleId;
  String returnId;
  String purchaseId;
  String referenceNo;
  String transactionId;
  String paidBy;
  String chequeNo;
  String ccNo;
  String ccHolder;
  String ccMonth;
  String ccYear;
  String ccType;
  String amount;
  String currency;
  String createdBy;
  String attachment;
  String type;
  String note;
  String posPaid;
  String posBalance;
  String approvalCode;
  String clientId;
  String flag;
  String isDeleted;
  String deviceId;
  String uuid;
  String uuidApp;
  String companyId;
  String consignmentId;
  String salesOrderId;
  String posPaymentRequestId;
  String cPaymentId;
  String referenceDist;
  String dateDist;
  String amountDist;
  String billingId;
  String urlImage;
  String idTemp;

  Payment(
      {this.id,
        this.date,
        this.saleId,
        this.returnId,
        this.purchaseId,
        this.referenceNo,
        this.transactionId,
        this.paidBy,
        this.chequeNo,
        this.ccNo,
        this.ccHolder,
        this.ccMonth,
        this.ccYear,
        this.ccType,
        this.amount,
        this.currency,
        this.createdBy,
        this.attachment,
        this.type,
        this.note,
        this.posPaid,
        this.posBalance,
        this.approvalCode,
        this.clientId,
        this.flag,
        this.isDeleted,
        this.deviceId,
        this.uuid,
        this.uuidApp,
        this.companyId,
        this.consignmentId,
        this.salesOrderId,
        this.posPaymentRequestId,
        this.cPaymentId,
        this.referenceDist,
        this.dateDist,
        this.amountDist,
        this.billingId,
        this.urlImage,
        this.idTemp});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    saleId = json['sale_id'];
    returnId = json['return_id'];
    purchaseId = json['purchase_id'];
    referenceNo = json['reference_no'];
    transactionId = json['transaction_id'];
    paidBy = json['paid_by'];
    chequeNo = json['cheque_no'];
    ccNo = json['cc_no'];
    ccHolder = json['cc_holder'];
    ccMonth = json['cc_month'];
    ccYear = json['cc_year'];
    ccType = json['cc_type'];
    amount = json['amount'];
    currency = json['currency'];
    createdBy = json['created_by'];
    attachment = json['attachment'];
    type = json['type'];
    note = json['note'];
    posPaid = json['pos_paid'];
    posBalance = json['pos_balance'];
    approvalCode = json['approval_code'];
    clientId = json['client_id'];
    flag = json['flag'];
    isDeleted = json['is_deleted'];
    deviceId = json['device_id'];
    uuid = json['uuid'];
    uuidApp = json['uuid_app'];
    companyId = json['company_id'];
    consignmentId = json['consignment_id'];
    salesOrderId = json['sales_order_id'];
    posPaymentRequestId = json['pos_payment_request_id'];
    cPaymentId = json['c_payment_id'];
    referenceDist = json['reference_dist'];
    dateDist = json['date_dist'];
    amountDist = json['amount_dist'];
    billingId = json['billing_id'];
    urlImage = json['url_image'];
    idTemp = json['id_temp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['sale_id'] = this.saleId;
    data['return_id'] = this.returnId;
    data['purchase_id'] = this.purchaseId;
    data['reference_no'] = this.referenceNo;
    data['transaction_id'] = this.transactionId;
    data['paid_by'] = this.paidBy;
    data['cheque_no'] = this.chequeNo;
    data['cc_no'] = this.ccNo;
    data['cc_holder'] = this.ccHolder;
    data['cc_month'] = this.ccMonth;
    data['cc_year'] = this.ccYear;
    data['cc_type'] = this.ccType;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['created_by'] = this.createdBy;
    data['attachment'] = this.attachment;
    data['type'] = this.type;
    data['note'] = this.note;
    data['pos_paid'] = this.posPaid;
    data['pos_balance'] = this.posBalance;
    data['approval_code'] = this.approvalCode;
    data['client_id'] = this.clientId;
    data['flag'] = this.flag;
    data['is_deleted'] = this.isDeleted;
    data['device_id'] = this.deviceId;
    data['uuid'] = this.uuid;
    data['uuid_app'] = this.uuidApp;
    data['company_id'] = this.companyId;
    data['consignment_id'] = this.consignmentId;
    data['sales_order_id'] = this.salesOrderId;
    data['pos_payment_request_id'] = this.posPaymentRequestId;
    data['c_payment_id'] = this.cPaymentId;
    data['reference_dist'] = this.referenceDist;
    data['date_dist'] = this.dateDist;
    data['amount_dist'] = this.amountDist;
    data['billing_id'] = this.billingId;
    data['url_image'] = this.urlImage;
    data['id_temp'] = this.idTemp;
    return data;
  }
}
