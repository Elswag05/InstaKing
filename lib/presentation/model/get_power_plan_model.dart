import 'dart:convert';

class GetPowerPlanModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetPowerPlanModel({
    this.status,
    this.message,
    this.data,
  });

  GetPowerPlanModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
  }) =>
      GetPowerPlanModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetPowerPlanModel.fromJson(Map<String, dynamic> json) =>
      GetPowerPlanModel.fromMap(json);

  String toJson() => json.encode(toMap());

  factory GetPowerPlanModel.fromMap(Map<String, dynamic> json) =>
      GetPowerPlanModel(
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
  int? id;
  String? name;
  String? fee;
  String? minimum;
  String? status;

  Datum({
    this.id,
    this.name,
    this.fee,
    this.minimum,
    this.status,
  });

  Datum copyWith({
    int? id,
    String? name,
    String? fee,
    String? minimum,
    String? status,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        fee: fee ?? this.fee,
        minimum: minimum ?? this.minimum,
        status: status ?? this.status,
      );

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        fee: json["fee"],
        minimum: json["minimum"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "fee": fee,
        "minimum": minimum,
        "status": status,
      };
}
