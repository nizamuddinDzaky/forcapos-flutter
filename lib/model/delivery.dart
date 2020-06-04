class Delivery {
  String id;
  String date;
  String saleId;
  String doReferenceNo;
  String saleReferenceNo;
  String customer;
  String address;
  String note;
  String status;
  String attachment;
  String spjFile;
  String receiveStatus;
  String deliveredBy;
  String receivedBy;
  String createdBy;
  String createdAt;
  String updatedBy;
  String updatedAt;
  String flag;
  String isDeleted;
  String deviceId;
  String uuid;
  String uuidApp;
  String deliveringDate;
  String deliveredDate;
  String returnReferenceNo;
  String isApproval;
  String isReject;
  String isConfirm;
  String biller;
  String alamatBiller;
  String emailBiller;
  String provinsiBiller;
  String stateBiller;
  String alamatCustomer;
  String emailCustomer;
  String provinsiCustomer;
  String stateCustomer;
  String clientId;

  Delivery(
      {this.id,
      this.date,
      this.saleId,
      this.doReferenceNo,
      this.saleReferenceNo,
      this.customer,
      this.address,
      this.note,
      this.status,
      this.attachment,
      this.spjFile,
      this.receiveStatus,
      this.deliveredBy,
      this.receivedBy,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.flag,
      this.isDeleted,
      this.deviceId,
      this.uuid,
      this.uuidApp,
      this.deliveringDate,
      this.deliveredDate,
      this.returnReferenceNo,
      this.isApproval,
      this.isReject,
      this.isConfirm,
      this.biller,
      this.alamatBiller,
      this.emailBiller,
      this.provinsiBiller,
      this.stateBiller,
      this.alamatCustomer,
      this.emailCustomer,
      this.provinsiCustomer,
      this.stateCustomer,
      this.clientId});

  Delivery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    saleId = json['sale_id'];
    doReferenceNo = json['do_reference_no'];
    saleReferenceNo = json['sale_reference_no'];
    customer = json['customer'];
    address = json['address'];
    note = json['note'];
    status = json['status'];
    attachment = json['attachment'];
    spjFile = json['spj_file'];
    receiveStatus = json['receive_status'];
    deliveredBy = json['delivered_by'];
    receivedBy = json['received_by'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    flag = json['flag'];
    isDeleted = json['is_deleted'];
    deviceId = json['device_id'];
    uuid = json['uuid'];
    uuidApp = json['uuid_app'];
    deliveringDate = json['delivering_date'];
    deliveredDate = json['delivered_date'];
    returnReferenceNo = json['return_reference_no'];
    isApproval = json['is_approval'];
    isReject = json['is_reject'];
    isConfirm = json['is_confirm'];
    biller = json['biller'];
    alamatBiller = json['alamat_biller'];
    emailBiller = json['email_biller'];
    provinsiBiller = json['provinsi_biller'];
    stateBiller = json['state_biller'];
    alamatCustomer = json['alamat_customer'];
    emailCustomer = json['email_customer'];
    provinsiCustomer = json['provinsi_customer'];
    stateCustomer = json['state_customer'];
    clientId = json['client_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['sale_id'] = this.saleId;
    data['do_reference_no'] = this.doReferenceNo;
    data['sale_reference_no'] = this.saleReferenceNo;
    data['customer'] = this.customer;
    data['address'] = this.address;
    data['note'] = this.note;
    data['status'] = this.status;
    data['attachment'] = this.attachment;
    data['spj_file'] = this.spjFile;
    data['receive_status'] = this.receiveStatus;
    data['delivered_by'] = this.deliveredBy;
    data['received_by'] = this.receivedBy;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['flag'] = this.flag;
    data['is_deleted'] = this.isDeleted;
    data['device_id'] = this.deviceId;
    data['uuid'] = this.uuid;
    data['uuid_app'] = this.uuidApp;
    data['delivering_date'] = this.deliveringDate;
    data['delivered_date'] = this.deliveredDate;
    data['return_reference_no'] = this.returnReferenceNo;
    data['is_approval'] = this.isApproval;
    data['is_reject'] = this.isReject;
    data['is_confirm'] = this.isConfirm;
    data['biller'] = this.biller;
    data['alamat_biller'] = this.alamatBiller;
    data['email_biller'] = this.emailBiller;
    data['provinsi_biller'] = this.provinsiBiller;
    data['state_biller'] = this.stateBiller;
    data['alamat_customer'] = this.alamatCustomer;
    data['email_customer'] = this.emailCustomer;
    data['provinsi_customer'] = this.provinsiCustomer;
    data['state_customer'] = this.stateCustomer;
    data['client_id'] = this.clientId;
    return data;
  }
}
