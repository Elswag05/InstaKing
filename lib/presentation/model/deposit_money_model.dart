import 'dart:convert';

class DepositMoneyModel {
  String? status;
  String? gateway;
  String? message;
  String? link;

  DepositMoneyModel({
    this.status,
    this.gateway,
    this.message,
    this.link,
  });

  DepositMoneyModel copyWith({
    String? status,
    String? gateway,
    String? message,
    String? link,
  }) =>
      DepositMoneyModel(
        status: status ?? this.status,
        gateway: gateway ?? this.gateway,
        message: message ?? this.message,
        link: link ?? this.link,
      );

  factory DepositMoneyModel.fromJson(String str) =>
      DepositMoneyModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DepositMoneyModel.fromMap(Map<String, dynamic> json) =>
      DepositMoneyModel(
        status: json["status"],
        gateway: json["gateway"],
        message: json["message"],
        link: json["link"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "gateway": gateway,
        "message": message,
        "link": link,
      };
}
