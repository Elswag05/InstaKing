import 'dart:convert';

class GetBanksModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetBanksModel({
    this.status,
    this.message,
    this.data,
  });

  GetBanksModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
  }) =>
      GetBanksModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetBanksModel.fromJson(String str) =>
      GetBanksModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetBanksModel.fromMap(Map<String, dynamic> json) => GetBanksModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  String? name;
  String? code;
  String? ussdTemplate;
  String? baseUssdCode;
  String? transferUssdTemplate;
  dynamic bankId;
  String? nipBankCode;

  Datum({
    this.name,
    this.code,
    this.ussdTemplate,
    this.baseUssdCode,
    this.transferUssdTemplate,
    this.bankId,
    this.nipBankCode,
  });

  Datum copyWith({
    String? name,
    String? code,
    String? ussdTemplate,
    String? baseUssdCode,
    String? transferUssdTemplate,
    dynamic bankId,
    String? nipBankCode,
  }) =>
      Datum(
        name: name ?? this.name,
        code: code ?? this.code,
        ussdTemplate: ussdTemplate ?? this.ussdTemplate,
        baseUssdCode: baseUssdCode ?? this.baseUssdCode,
        transferUssdTemplate: transferUssdTemplate ?? this.transferUssdTemplate,
        bankId: bankId ?? this.bankId,
        nipBankCode: nipBankCode ?? this.nipBankCode,
      );

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        name: json["name"],
        code: json["code"],
        ussdTemplate: json["ussdTemplate"],
        baseUssdCode: json["baseUssdCode"],
        transferUssdTemplate: json["transferUssdTemplate"],
        bankId: json["bankId"],
        nipBankCode: json["nipBankCode"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "code": code,
        "ussdTemplate": ussdTemplate,
        "baseUssdCode": baseUssdCode,
        "transferUssdTemplate": transferUssdTemplate,
        "bankId": bankId,
        "nipBankCode": nipBankCode,
      };
}
