import 'dart:convert';

class GetCableDecoderModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetCableDecoderModel({
    this.status,
    this.message,
    this.data,
  });

  GetCableDecoderModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
  }) =>
      GetCableDecoderModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetCableDecoderModel.fromJson(String str) =>
      GetCableDecoderModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetCableDecoderModel.fromMap(Map<String, dynamic> json) =>
      GetCableDecoderModel(
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
  String? image;
  String? name;
  int? status;

  Datum({
    this.id,
    this.image,
    this.name,
    this.status,
  });

  Datum copyWith({
    int? id,
    String? image,
    String? name,
    int? status,
  }) =>
      Datum(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        status: status ?? this.status,
      );

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "name": name,
        "status": status,
      };
}
