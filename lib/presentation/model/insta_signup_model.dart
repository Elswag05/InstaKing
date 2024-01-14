// ignore_for_file: unnecessary_question_mark, unnecessary_this, unnecessary_new, prefer_collection_literals

class InstaSignUpModel {
  String? status;
  String? message;
  String? token;
  User? user;

  InstaSignUpModel({this.status, this.message, this.token, this.user});

  InstaSignUpModel.fromJson(Map<String, dynamic> json) {
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
  String? lname;
  String? fname;
  String? username;
  String? email;
  String? phone;
  String? userRole;
  int? refId;
  String? emailVerifiedAt;
  String? apiToken;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? firstName;
  String? lastName;
  Null? virtualBanks;
  String? fullname;

  User(
      {this.lname,
      this.fname,
      this.username,
      this.email,
      this.phone,
      this.userRole,
      this.refId,
      this.emailVerifiedAt,
      this.apiToken,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.firstName,
      this.lastName,
      this.virtualBanks,
      this.fullname});

  User.fromJson(Map<String, dynamic> json) {
    lname = json['lname'];
    fname = json['fname'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    userRole = json['user_role'];
    refId = json['ref_id'];
    emailVerifiedAt = json['email_verified_at'];
    apiToken = json['api_token'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    virtualBanks = json['virtual_banks'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lname'] = this.lname;
    data['fname'] = this.fname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['user_role'] = this.userRole;
    data['ref_id'] = this.refId;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['api_token'] = this.apiToken;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['virtual_banks'] = this.virtualBanks;
    data['fullname'] = this.fullname;
    return data;
  }
}
