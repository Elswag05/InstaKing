import 'dart:convert';

class ProfileModel {
    String? status;
    String? message;
    User? user;

    ProfileModel({
        this.status,
        this.message,
        this.user,
    });

    ProfileModel copyWith({
        String? status,
        String? message,
        User? user,
    }) => 
        ProfileModel(
            status: status ?? this.status,
            message: message ?? this.message,
            user: user ?? this.user,
        );

    factory ProfileModel.fromRawJson(String str) => ProfileModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user?.toJson(),
    };
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
    dynamic country;
    String? balance;
    String? bonus;
    String? apiToken;
    dynamic image;
    dynamic address;
    dynamic virtualRef;
    dynamic virtualBanks;
    dynamic bankName;
    dynamic accName;
    dynamic accNumber;
    String? status;
    DateTime? emailVerifiedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? firstName;
    String? lastName;
    String? bankname;
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
        this.bankname,
        this.fullname,
    });

    User copyWith({
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
        dynamic image,
        dynamic address,
        dynamic virtualRef,
        dynamic virtualBanks,
        dynamic bankName,
        dynamic accName,
        dynamic accNumber,
        String? status,
        DateTime? emailVerifiedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? firstName,
        String? lastName,
        String? bankname,
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
            bankname: bankname ?? this.bankname,
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
        virtualBanks: json["virtual_banks"],
        bankName: json["bank_name"],
        accName: json["acc_name"],
        accNumber: json["acc_number"],
        status: json["status"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        bankname: json["bankname"],
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
        "virtual_banks": virtualBanks,
        "bank_name": bankName,
        "acc_name": accName,
        "acc_number": accNumber,
        "status": status,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "bankname": bankname,
        "fullname": fullname,
    };
}
