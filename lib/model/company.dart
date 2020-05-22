import 'package:posku/model/user.dart';

class Company {
  String id;
  String groupId;
  String groupName;
  String companyId;
  String customerGroupId;
  String customerGroupName;
  String name;
  String company;
  String vatNo;
  String region;
  String address;
  String city;
  String state;
  String village;
  String postalCode;
  String country;
  String phone;
  String email;
  String cf1;
  String cf2;
  String cf3;
  String cf4;
  String cf5;
  String cf6;
  String invoiceFooter;
  String paymentTerm;
  String logo;
  String awardPoints;
  String depositAmount;
  String priceGroupId;
  String priceGroupName;
  String clientId;
  String flag;
  String flagBk;
  String isDeleted;
  String deviceId;
  String uuid;
  String uuidApp;
  String managerArea;
  String mtid;
  String latitude;
  String longitude;
  String salesPersonId;
  String salesPersonRef;
  String isActive;
  String createdAt;
  String updatedAt;
  User user;

  Company(
      {this.id,
        this.groupId,
        this.groupName,
        this.companyId,
        this.customerGroupId,
        this.customerGroupName,
        this.name,
        this.company,
        this.vatNo,
        this.region,
        this.address,
        this.city,
        this.state,
        this.village,
        this.postalCode,
        this.country,
        this.phone,
        this.email,
        this.cf1,
        this.cf2,
        this.cf3,
        this.cf4,
        this.cf5,
        this.cf6,
        this.invoiceFooter,
        this.paymentTerm,
        this.logo,
        this.awardPoints,
        this.depositAmount,
        this.priceGroupId,
        this.priceGroupName,
        this.clientId,
        this.flag,
        this.flagBk,
        this.isDeleted,
        this.deviceId,
        this.uuid,
        this.uuidApp,
        this.managerArea,
        this.mtid,
        this.latitude,
        this.longitude,
        this.salesPersonId,
        this.salesPersonRef,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.user});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    groupName = json['group_name'];
    companyId = json['company_id'];
    customerGroupId = json['customer_group_id'];
    customerGroupName = json['customer_group_name'];
    name = json['name'];
    company = json['company'];
    vatNo = json['vat_no'];
    region = json['region'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    village = json['village'];
    postalCode = json['postal_code'];
    country = json['country'];
    phone = json['phone'];
    email = json['email'];
    cf1 = json['cf1'];
    cf2 = json['cf2'];
    cf3 = json['cf3'];
    cf4 = json['cf4'];
    cf5 = json['cf5'];
    cf6 = json['cf6'];
    invoiceFooter = json['invoice_footer'];
    paymentTerm = json['payment_term'];
    logo = json['logo'];
    awardPoints = json['award_points'];
    depositAmount = json['deposit_amount'];
    priceGroupId = json['price_group_id'];
    priceGroupName = json['price_group_name'];
    clientId = json['client_id'];
    flag = json['flag'];
    flagBk = json['flag_bk'];
    isDeleted = json['is_deleted'];
    deviceId = json['device_id'];
    uuid = json['uuid'];
    uuidApp = json['uuid_app'];
    managerArea = json['manager_area'];
    mtid = json['mtid'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    salesPersonId = json['sales_person_id'];
    salesPersonRef = json['sales_person_ref'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['user'] != null) {
      user = User.fromJson(json['user']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['group_name'] = this.groupName;
    data['company_id'] = this.companyId;
    data['customer_group_id'] = this.customerGroupId;
    data['customer_group_name'] = this.customerGroupName;
    data['name'] = this.name;
    data['company'] = this.company;
    data['vat_no'] = this.vatNo;
    data['region'] = this.region;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['village'] = this.village;
    data['postal_code'] = this.postalCode;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['cf1'] = this.cf1;
    data['cf2'] = this.cf2;
    data['cf3'] = this.cf3;
    data['cf4'] = this.cf4;
    data['cf5'] = this.cf5;
    data['cf6'] = this.cf6;
    data['invoice_footer'] = this.invoiceFooter;
    data['payment_term'] = this.paymentTerm;
    data['logo'] = this.logo;
    data['award_points'] = this.awardPoints;
    data['deposit_amount'] = this.depositAmount;
    data['price_group_id'] = this.priceGroupId;
    data['price_group_name'] = this.priceGroupName;
    data['client_id'] = this.clientId;
    data['flag'] = this.flag;
    data['flag_bk'] = this.flagBk;
    data['is_deleted'] = this.isDeleted;
    data['device_id'] = this.deviceId;
    data['uuid'] = this.uuid;
    data['uuid_app'] = this.uuidApp;
    data['manager_area'] = this.managerArea;
    data['mtid'] = this.mtid;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['sales_person_id'] = this.salesPersonId;
    data['sales_person_ref'] = this.salesPersonRef;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user'] = this.user?.toJson();
    return data;
  }
}
