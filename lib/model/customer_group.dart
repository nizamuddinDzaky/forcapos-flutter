class CustomerGroup {
  String id;
  String name;
  String percent;
  String clientId;
  String flag;
  String isDeleted;
  String deviceId;
  String uuid;
  String uuidApp;
  String companyId;
  String kreditLimit;

  CustomerGroup(
      {this.id,
        this.name,
        this.percent,
        this.clientId,
        this.flag,
        this.isDeleted,
        this.deviceId,
        this.uuid,
        this.uuidApp,
        this.companyId,
        this.kreditLimit});

  CustomerGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    percent = json['percent'];
    clientId = json['client_id'];
    flag = json['flag'];
    isDeleted = json['is_deleted'];
    deviceId = json['device_id'];
    uuid = json['uuid'];
    uuidApp = json['uuid_app'];
    companyId = json['company_id'];
    kreditLimit = json['kredit_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['percent'] = this.percent;
    data['client_id'] = this.clientId;
    data['flag'] = this.flag;
    data['is_deleted'] = this.isDeleted;
    data['device_id'] = this.deviceId;
    data['uuid'] = this.uuid;
    data['uuid_app'] = this.uuidApp;
    data['company_id'] = this.companyId;
    data['kredit_limit'] = this.kreditLimit;
    return data;
  }
}