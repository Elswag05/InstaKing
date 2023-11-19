import 'dart:convert';

class GetCategoriesModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetCategoriesModel({
    this.status,
    this.message,
    this.data,
  });

  GetCategoriesModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
  }) =>
      GetCategoriesModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetCategoriesModel.fromRawJson(String str) =>
      GetCategoriesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetCategoriesModel.fromJson(Map<String, dynamic> json) =>
      GetCategoriesModel(
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
  int? id;
  String? name;
  dynamic desc;
  String? status;

  Datum({
    this.id,
    this.name,
    this.desc,
    this.status,
  });

  Datum copyWith({
    int? id,
    String? name,
    dynamic desc,
    String? status,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        desc: desc ?? this.desc,
        status: status ?? this.status,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        desc: json["desc"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
        "status": status,
      };
}
