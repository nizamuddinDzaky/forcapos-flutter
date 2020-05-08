class User {
  String id;
  String lastIpAddress;
  String ipAddress;
  String authProvider;
  String username;
  String password;
  String salt;
  String email;
  String activationCode;
  String forgottenPasswordCode;
  String forgottenPasswordTime;
  String rememberCode;
  String createdOn;
  String lastLogin;
  String active;
  String firstName;
  String lastName;
  String company;
  String phone;
  String avatar;
  String gender;
  String groupId;
  String warehouseId;
  String billerId;
  String companyId;
  String showCost;
  String showPrice;
  String awardPoints;
  String viewRight;
  String editRight;
  String allowDiscount;
  String deviceId;
  String customerGroupId;
  String supplierId;
  String salesPersonId;
  String salesPersonRef;
  String issupplier;
  String managerArea;
  String groupCalluser;
  String country;
  String city;
  String state;
  String address;
  String phoneIsVerified;
  String phoneOtp;
  String activatedAt;
  String registeredBy;
  String lastUpdate;
  String lastSentActivationCodeAt;

  User(
      {this.id,
        this.lastIpAddress,
        this.ipAddress,
        this.authProvider,
        this.username,
        this.password,
        this.salt,
        this.email,
        this.activationCode,
        this.forgottenPasswordCode,
        this.forgottenPasswordTime,
        this.rememberCode,
        this.createdOn,
        this.lastLogin,
        this.active,
        this.firstName,
        this.lastName,
        this.company,
        this.phone,
        this.avatar,
        this.gender,
        this.groupId,
        this.warehouseId,
        this.billerId,
        this.companyId,
        this.showCost,
        this.showPrice,
        this.awardPoints,
        this.viewRight,
        this.editRight,
        this.allowDiscount,
        this.deviceId,
        this.customerGroupId,
        this.supplierId,
        this.salesPersonId,
        this.salesPersonRef,
        this.issupplier,
        this.managerArea,
        this.groupCalluser,
        this.country,
        this.city,
        this.state,
        this.address,
        this.phoneIsVerified,
        this.phoneOtp,
        this.activatedAt,
        this.registeredBy,
        this.lastUpdate,
        this.lastSentActivationCodeAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastIpAddress = json['last_ip_address'];
    ipAddress = json['ip_address'];
    authProvider = json['auth_provider'];
    username = json['username'];
    password = json['password'];
    salt = json['salt'];
    email = json['email'];
    activationCode = json['activation_code'];
    forgottenPasswordCode = json['forgotten_password_code'];
    forgottenPasswordTime = json['forgotten_password_time'];
    rememberCode = json['remember_code'];
    createdOn = json['created_on'];
    lastLogin = json['last_login'];
    active = json['active'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    phone = json['phone'];
    avatar = json['avatar'];
    gender = json['gender'];
    groupId = json['group_id'];
    warehouseId = json['warehouse_id'];
    billerId = json['biller_id'];
    companyId = json['company_id'];
    showCost = json['show_cost'];
    showPrice = json['show_price'];
    awardPoints = json['award_points'];
    viewRight = json['view_right'];
    editRight = json['edit_right'];
    allowDiscount = json['allow_discount'];
    deviceId = json['device_id'];
    customerGroupId = json['customer_group_id'];
    supplierId = json['supplier_id'];
    salesPersonId = json['sales_person_id'];
    salesPersonRef = json['sales_person_ref'];
    issupplier = json['issupplier'];
    managerArea = json['manager_area'];
    groupCalluser = json['group_calluser'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    phoneIsVerified = json['phone_is_verified'];
    phoneOtp = json['phone_otp'];
    activatedAt = json['activated_at'];
    registeredBy = json['registered_by'];
    lastUpdate = json['last_update'];
    lastSentActivationCodeAt = json['last_sent_activation_code_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['last_ip_address'] = this.lastIpAddress;
    data['ip_address'] = this.ipAddress;
    data['auth_provider'] = this.authProvider;
    data['username'] = this.username;
    data['password'] = this.password;
    data['salt'] = this.salt;
    data['email'] = this.email;
    data['activation_code'] = this.activationCode;
    data['forgotten_password_code'] = this.forgottenPasswordCode;
    data['forgotten_password_time'] = this.forgottenPasswordTime;
    data['remember_code'] = this.rememberCode;
    data['created_on'] = this.createdOn;
    data['last_login'] = this.lastLogin;
    data['active'] = this.active;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company'] = this.company;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['gender'] = this.gender;
    data['group_id'] = this.groupId;
    data['warehouse_id'] = this.warehouseId;
    data['biller_id'] = this.billerId;
    data['company_id'] = this.companyId;
    data['show_cost'] = this.showCost;
    data['show_price'] = this.showPrice;
    data['award_points'] = this.awardPoints;
    data['view_right'] = this.viewRight;
    data['edit_right'] = this.editRight;
    data['allow_discount'] = this.allowDiscount;
    data['device_id'] = this.deviceId;
    data['customer_group_id'] = this.customerGroupId;
    data['supplier_id'] = this.supplierId;
    data['sales_person_id'] = this.salesPersonId;
    data['sales_person_ref'] = this.salesPersonRef;
    data['issupplier'] = this.issupplier;
    data['manager_area'] = this.managerArea;
    data['group_calluser'] = this.groupCalluser;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['address'] = this.address;
    data['phone_is_verified'] = this.phoneIsVerified;
    data['phone_otp'] = this.phoneOtp;
    data['activated_at'] = this.activatedAt;
    data['registered_by'] = this.registeredBy;
    data['last_update'] = this.lastUpdate;
    data['last_sent_activation_code_at'] = this.lastSentActivationCodeAt;
    return data;
  }
}
