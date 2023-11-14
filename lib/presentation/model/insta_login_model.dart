class InstaLoginModel {
  String? status;
  String? message;
  String? token;
  User? user;

  InstaLoginModel({this.status, this.message, this.token, this.user});

  InstaLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  Null refId;
  String? userRole;
  String? fname;
  String? lname;
  String? username;
  String? email;
  String? phone;
  Null country;
  String? balance;
  String? bonus;
  String? apiToken;
  Null image;
  String? address;
  String? virtualRef;
  List<VirtualBanks>? virtualBanks;
  String? bankName;
  String? accName;
  String? accNumber;
  String? status;
  Null emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? fullname;

  User(
      {this.id,
      this.refId,
      this.userRole,
      this.fname,
      this.lname,
      this.username,
      this.email,
      this.phone,
      this.country,
      this.balance,
      this.bonus,
      this.apiToken,
      this.image,
      this.address,
      this.virtualRef,
      this.virtualBanks,
      this.bankName,
      this.accName,
      this.accNumber,
      this.status,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.firstName,
      this.lastName,
      this.fullname});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refId = json['ref_id'];
    userRole = json['user_role'];
    fname = json['fname'];
    lname = json['lname'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    country = json['country'];
    balance = json['balance'];
    bonus = json['bonus'];
    apiToken = json['api_token'];
    image = json['image'];
    address = json['address'];
    virtualRef = json['virtual_ref'];
    if (json['virtual_banks'] != null) {
      virtualBanks = <VirtualBanks>[];
      json['virtual_banks'].forEach((v) {
        virtualBanks!.add(VirtualBanks.fromJson(v));
      });
    }
    bankName = json['bank_name'];
    accName = json['acc_name'];
    accNumber = json['acc_number'];
    status = json['status'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ref_id'] = refId;
    data['user_role'] = userRole;
    data['fname'] = fname;
    data['lname'] = lname;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['country'] = country;
    data['balance'] = balance;
    data['bonus'] = bonus;
    data['api_token'] = apiToken;
    data['image'] = image;
    data['address'] = address;
    data['virtual_ref'] = virtualRef;
    if (virtualBanks != null) {
      data['virtual_banks'] = virtualBanks!.map((v) => v.toJson()).toList();
    }
    data['bank_name'] = bankName;
    data['acc_name'] = accName;
    data['acc_number'] = accNumber;
    data['status'] = status;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['fullname'] = fullname;
    return data;
  }
}

class VirtualBanks {
  String? bankCode;
  String? bankName;
  String? accountNumber;
  String? accountName;

  VirtualBanks(
      {this.bankCode, this.bankName, this.accountNumber, this.accountName});

  VirtualBanks.fromJson(Map<String, dynamic> json) {
    bankCode = json['bankCode'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    accountName = json['accountName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bankCode'] = bankCode;
    data['bankName'] = bankName;
    data['accountNumber'] = accountNumber;
    data['accountName'] = accountName;
    return data;
  }
}
