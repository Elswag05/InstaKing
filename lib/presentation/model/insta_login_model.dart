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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? refId;
  String? userRole;
  String? fname;
  String? lname;
  String? username;
  String? email;
  String? phone;
  Null? country;
  String? balance;
  String? bonus;
  String? apiToken;
  Null? image;
  Null? address;
  Null? virtualRef;
  Null? virtualBanks;
  Null? bankName;
  Null? accName;
  Null? accNumber;
  String? status;
  String? emailVerifiedAt;
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
    virtualBanks = json['virtual_banks'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ref_id'] = this.refId;
    data['user_role'] = this.userRole;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['country'] = this.country;
    data['balance'] = this.balance;
    data['bonus'] = this.bonus;
    data['api_token'] = this.apiToken;
    data['image'] = this.image;
    data['address'] = this.address;
    data['virtual_ref'] = this.virtualRef;
    data['virtual_banks'] = this.virtualBanks;
    data['bank_name'] = this.bankName;
    data['acc_name'] = this.accName;
    data['acc_number'] = this.accNumber;
    data['status'] = this.status;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['fullname'] = this.fullname;
    return data;
  }
}
