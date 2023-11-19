import 'dart:convert';

class PlaceOrderModel {
  String? status;
  String? message;
  Data? data;

  PlaceOrderModel({
    this.status,
    this.message,
    this.data,
  });

  PlaceOrderModel copyWith({
    String? status,
    String? message,
    Data? data,
  }) =>
      PlaceOrderModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory PlaceOrderModel.fromRawJson(String str) =>
      PlaceOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      PlaceOrderModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? orderId;
  String? status;
  String? trx;

  Data({
    this.orderId,
    this.status,
    this.trx,
  });

  Data copyWith({
    int? orderId,
    String? status,
    String? trx,
  }) =>
      Data(
        orderId: orderId ?? this.orderId,
        status: status ?? this.status,
        trx: trx ?? this.trx,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderId: json["orderId"],
        status: json["status"],
        trx: json["trx"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "status": status,
        "trx": trx,
      };
}
