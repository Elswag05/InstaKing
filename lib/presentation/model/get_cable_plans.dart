import 'dart:convert';

class GetCablePlanModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetCablePlanModel({
    this.status,
    this.message,
    this.data,
  });

  GetCablePlanModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
  }) =>
      GetCablePlanModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetCablePlanModel.fromJson(Map<String, dynamic> json) =>
      GetCablePlanModel.fromMap(json);

  String toJson() => json.encode(toMap());

  factory GetCablePlanModel.fromMap(Map<String, dynamic> json) =>
      GetCablePlanModel(
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
  String? cable;
  int? id;
  String? price;
  String? name;

  Datum({
    this.cable,
    this.id,
    this.price,
    this.name,
  });

  Datum copyWith({
    String? cable,
    int? id,
    String? price,
    String? name,
  }) =>
      Datum(
        cable: cable ?? this.cable,
        id: id ?? this.id,
        price: price ?? this.price,
        name: name ?? this.name,
      );

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        cable: json["cable"],
        id: json["id"],
        price: json["price"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "cable": cable,
        "id": id,
        "price": price,
        "name": name,
      };
}
