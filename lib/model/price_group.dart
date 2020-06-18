class PriceGroup {
  String id;
  String name;
  String clientId;
  String flag;
  String isDeleted;
  String deviceId;
  String uuid;
  String uuidApp;
  String companyId;
  String warehouseId;

  PriceGroup(
      {this.id,
        this.name,
        this.clientId,
        this.flag,
        this.isDeleted,
        this.deviceId,
        this.uuid,
        this.uuidApp,
        this.companyId,
        this.warehouseId});

  PriceGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    clientId = json['client_id'];
    flag = json['flag'];
    isDeleted = json['is_deleted'];
    deviceId = json['device_id'];
    uuid = json['uuid'];
    uuidApp = json['uuid_app'];
    companyId = json['company_id'];
    warehouseId = json['warehouse_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['client_id'] = this.clientId;
    data['flag'] = this.flag;
    data['is_deleted'] = this.isDeleted;
    data['device_id'] = this.deviceId;
    data['uuid'] = this.uuid;
    data['uuid_app'] = this.uuidApp;
    data['company_id'] = this.companyId;
    data['warehouse_id'] = this.warehouseId;
    return data;
  }

  @override
  String toString() {
    return name;
  }
}