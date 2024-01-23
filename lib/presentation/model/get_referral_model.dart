import 'dart:convert';

class GetReferralsModel {
  String? status;
  String? message;
  List<Datum>? data;
  int? total;
  int? currentPage;
  dynamic previousPage;
  dynamic nextPage;
  int? lastPage;

  GetReferralsModel({
    this.status,
    this.message,
    this.data,
    this.total,
    this.currentPage,
    this.previousPage,
    this.nextPage,
    this.lastPage,
  });

  GetReferralsModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
    int? total,
    int? currentPage,
    dynamic previousPage,
    dynamic nextPage,
    int? lastPage,
  }) =>
      GetReferralsModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        total: total ?? this.total,
        currentPage: currentPage ?? this.currentPage,
        previousPage: previousPage ?? this.previousPage,
        nextPage: nextPage ?? this.nextPage,
        lastPage: lastPage ?? this.lastPage,
      );

  factory GetReferralsModel.fromJson(Map<String, dynamic> json) =>
      GetReferralsModel.fromMap(json);

  String toJson() => json.encode(toMap());

  factory GetReferralsModel.fromMap(Map<String, dynamic> json) =>
      GetReferralsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        total: json["total"],
        currentPage: json["current_page"],
        previousPage: json["previous_page"],
        nextPage: json["next_page"],
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "total": total,
        "current_page": currentPage,
        "previous_page": previousPage,
        "next_page": nextPage,
        "last_page": lastPage,
      };
}

class Datum {
  int? id;
  String? refId;
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
  String? image;
  dynamic address;
  dynamic verifyMethod;
  dynamic bvn;
  dynamic nin;
  String? kycStatus;
  String? virtualRef;
  String? virtualBanks;
  String? bankName;
  String? accName;
  String? accNumber;
  String? status;
  String? wm;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fullname;

  Datum({
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
    this.verifyMethod,
    this.bvn,
    this.nin,
    this.kycStatus,
    this.virtualRef,
    this.virtualBanks,
    this.bankName,
    this.accName,
    this.accNumber,
    this.status,
    this.wm,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.fullname,
  });

  Datum copyWith({
    int? id,
    String? refId,
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
    String? image,
    dynamic address,
    dynamic verifyMethod,
    dynamic bvn,
    dynamic nin,
    String? kycStatus,
    String? virtualRef,
    String? virtualBanks,
    String? bankName,
    String? accName,
    String? accNumber,
    String? status,
    String? wm,
    DateTime? emailVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? fullname,
  }) =>
      Datum(
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
        verifyMethod: verifyMethod ?? this.verifyMethod,
        bvn: bvn ?? this.bvn,
        nin: nin ?? this.nin,
        kycStatus: kycStatus ?? this.kycStatus,
        virtualRef: virtualRef ?? this.virtualRef,
        virtualBanks: virtualBanks ?? this.virtualBanks,
        bankName: bankName ?? this.bankName,
        accName: accName ?? this.accName,
        accNumber: accNumber ?? this.accNumber,
        status: status ?? this.status,
        wm: wm ?? this.wm,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        fullname: fullname ?? this.fullname,
      );

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
        verifyMethod: json["verify_method"],
        bvn: json["bvn"],
        nin: json["nin"],
        kycStatus: json["kyc_status"],
        virtualRef: json["virtual_ref"],
        virtualBanks: json["virtual_banks"],
        bankName: json["bank_name"],
        accName: json["acc_name"],
        accNumber: json["acc_number"],
        status: json["status"],
        wm: json["wm"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fullname: json["fullname"],
      );

  Map<String, dynamic> toMap() => {
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
        "verify_method": verifyMethod,
        "bvn": bvn,
        "nin": nin,
        "kyc_status": kycStatus,
        "virtual_ref": virtualRef,
        "virtual_banks": virtualBanks,
        "bank_name": bankName,
        "acc_name": accName,
        "acc_number": accNumber,
        "status": status,
        "wm": wm,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "fullname": fullname,
      };
}
