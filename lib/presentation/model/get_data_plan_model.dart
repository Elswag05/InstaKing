import 'dart:convert';

class GetDataPlanModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetDataPlanModel({
    this.status,
    this.message,
    this.data,
  });

  GetDataPlanModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
  }) =>
      GetDataPlanModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetDataPlanModel.fromJson(Map<String, dynamic> json) =>
      GetDataPlanModel.fromMap(json);

  String toJson() => json.encode(toMap());

  factory GetDataPlanModel.fromMap(Map<String, dynamic> json) =>
      GetDataPlanModel(
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
  String? network;
  int? id;
  String? type;
  String? price;
  String? name;

  Datum({
    this.network,
    this.id,
    this.type,
    this.price,
    this.name,
  });

  Datum copyWith({
    String? network,
    int? id,
    String? type,
    String? price,
    String? name,
  }) =>
      Datum(
        network: network ?? this.network,
        id: id ?? this.id,
        type: type ?? this.type,
        price: price ?? this.price,
        name: name ?? this.name,
      );

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        network: json["network"],
        id: json["id"],
        type: json["type"],
        price: json["price"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "network": network,
        "id": id,
        "type": type,
        "price": price,
        "name": name,
      };
}
