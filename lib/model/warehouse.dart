class Warehouse {
  String id;
  String code;
  String name;
  String address;
  String map;
  String phone;
  String email;
  String priceGroupId;
  String clientId;
  String companyId;
  String flag;
  String isDeleted;
  String deviceId;
  String uuid;
  String uuidApp;
  String shipmentPriceGroupId;
  String active;

  Warehouse(
      {this.id,
        this.code,
        this.name,
        this.address,
        this.map,
        this.phone,
        this.email,
        this.priceGroupId,
        this.clientId,
        this.companyId,
        this.flag,
        this.isDeleted,
        this.deviceId,
        this.uuid,
        this.uuidApp,
        this.shipmentPriceGroupId,
        this.active});

  Warehouse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    address = json['address'];
    map = json['map'];
    phone = json['phone'];
    email = json['email'];
    priceGroupId = json['price_group_id'];
    clientId = json['client_id'];
    companyId = json['company_id'];
    flag = json['flag'];
    isDeleted = json['is_deleted'];
    deviceId = json['device_id'];
    uuid = json['uuid'];
    uuidApp = json['uuid_app'];
    shipmentPriceGroupId = json['shipment_price_group_id'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['address'] = this.address;
    data['map'] = this.map;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['price_group_id'] = this.priceGroupId;
    data['client_id'] = this.clientId;
    data['company_id'] = this.companyId;
    data['flag'] = this.flag;
    data['is_deleted'] = this.isDeleted;
    data['device_id'] = this.deviceId;
    data['uuid'] = this.uuid;
    data['uuid_app'] = this.uuidApp;
    data['shipment_price_group_id'] = this.shipmentPriceGroupId;
    data['active'] = this.active;
    return data;
  }

  @override
  String toString() {
    return name;
  }
}
