import 'dart:convert';

class InstaLoginModel {
  String? status;
  String? message;
  String? token;
  User? user;

  InstaLoginModel({
    this.status,
    this.message,
    this.token,
    this.user,
  });

  InstaLoginModel copyWith({
    String? status,
    String? message,
    String? token,
    User? user,
  }) =>
      InstaLoginModel(
        status: status ?? this.status,
        message: message ?? this.message,
        token: token ?? this.token,
        user: user ?? this.user,
      );

  factory InstaLoginModel.fromRawJson(String str) =>
      InstaLoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InstaLoginModel.fromJson(Map<String, dynamic> json) =>
      InstaLoginModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  dynamic refId;
  String? userRole;
  String? fname;
  String? lname;
  String? username;
  String? email;
  String? phone;
  dynamic country;
  String? balance;
  String? bonus;
  String? apiToken;
  dynamic image;
  String? address;
  String? virtualRef;
  List<VirtualBank>? virtualBanks;
  String? bankName;
  String? accName;
  String? accNumber;
  String? status;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? firstName;
  String? lastName;
  String? fullname;

  User({
    this.id,
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
    this.fullname,
  });

  User copyWith({
    int? id,
    dynamic refId,
    String? userRole,
    String? fname,
    String? lname,
    String? username,
    String? email,
    String? phone,
    dynamic country,
    String? balance,
    String? bonus,
    String? apiToken,
    dynamic image,
    String? address,
    String? virtualRef,
    List<VirtualBank>? virtualBanks,
    String? bankName,
    String? accName,
    String? accNumber,
    String? status,
    dynamic emailVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? firstName,
    String? lastName,
    String? fullname,
  }) =>
      User(
        id: id ?? this.id,
        refId: refId ?? this.refId,
        userRole: userRole ?? this.userRole,
        fname: fname ?? this.fname,
        lname: lname ?? this.lname,
        username: username ?? this.username,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        country: country ?? this.country,
        balance: balance ?? this.balance,
        bonus: bonus ?? this.bonus,
        apiToken: apiToken ?? this.apiToken,
        image: image ?? this.image,
        address: address ?? this.address,
        virtualRef: virtualRef ?? this.virtualRef,
        virtualBanks: virtualBanks ?? this.virtualBanks,
        bankName: bankName ?? this.bankName,
        accName: accName ?? this.accName,
        accNumber: accNumber ?? this.accNumber,
        status: status ?? this.status,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        fullname: fullname ?? this.fullname,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        refId: json["ref_id"],
        userRole: json["user_role"],
        fname: json["fname"],
        lname: json["lname"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        country: json["country"],
        balance: json["balance"],
        bonus: json["bonus"],
        apiToken: json["api_token"],
        image: json["image"],
        address: json["address"],
        virtualRef: json["virtual_ref"],
        virtualBanks: json["virtual_banks"] == null
            ? []
            : List<VirtualBank>.from(
                json["virtual_banks"]!.map((x) => VirtualBank.fromJson(x))),
        bankName: json["bank_name"],
        accName: json["acc_name"],
        accNumber: json["acc_number"],
        status: json["status"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        fullname: json["fullname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ref_id": refId,
        "user_role": userRole,
        "fname": fname,
        "lname": lname,
        "username": username,
        "email": email,
        "phone": phone,
        "country": country,
        "balance": balance,
        "bonus": bonus,
        "api_token": apiToken,
        "image": image,
        "address": address,
        "virtual_ref": virtualRef,
        "virtual_banks": virtualBanks == null
            ? []
            : List<dynamic>.from(virtualBanks!.map((x) => x.toJson())),
        "bank_name": bankName,
        "acc_name": accName,
        "acc_number": accNumber,
        "status": status,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "fullname": fullname,
      };
}

class VirtualBank {
  String? bankCode;
  String? bankName;
  String? accountNumber;
  String? accountName;

  VirtualBank({
    this.bankCode,
    this.bankName,
    this.accountNumber,
    this.accountName,
  });

  VirtualBank copyWith({
    String? bankCode,
    String? bankName,
    String? accountNumber,
    String? accountName,
  }) =>
      VirtualBank(
        bankCode: bankCode ?? this.bankCode,
        bankName: bankName ?? this.bankName,
        accountNumber: accountNumber ?? this.accountNumber,
        accountName: accountName ?? this.accountName,
      );

  factory VirtualBank.fromRawJson(String str) =>
      VirtualBank.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VirtualBank.fromJson(Map<String, dynamic> json) => VirtualBank(
        bankCode: json["bankCode"],
        bankName: json["bankName"],
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
      );

  Map<String, dynamic> toJson() => {
        "bankCode": bankCode,
        "bankName": bankName,
        "accountNumber": accountNumber,
        "accountName": accountName,
      };
}
