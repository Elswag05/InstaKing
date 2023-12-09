import 'dart:convert';

class GenerateAccountModel {
  String? status;
  String? message;
  List<Datum>? data;

  GenerateAccountModel({
    this.status,
    this.message,
    this.data,
  });

  GenerateAccountModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
  }) =>
      GenerateAccountModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GenerateAccountModel.fromRawJson(String str) =>
      GenerateAccountModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GenerateAccountModel.fromJson(Map<String, dynamic> json) =>
      GenerateAccountModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? bankCode;
  String? bankName;
  String? accountNumber;
  String? accountName;

  Datum({
    this.bankCode,
    this.bankName,
    this.accountNumber,
    this.accountName,
  });

  Datum copyWith({
    String? bankCode,
    String? bankName,
    String? accountNumber,
    String? accountName,
  }) =>
      Datum(
        bankCode: bankCode ?? this.bankCode,
        bankName: bankName ?? this.bankName,
        accountNumber: accountNumber ?? this.accountNumber,
        accountName: accountName ?? this.accountName,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
