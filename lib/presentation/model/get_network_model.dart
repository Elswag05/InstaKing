import 'dart:convert';

class GetNetworkModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetNetworkModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetNetworkModel.fromJson(String str) =>
      GetNetworkModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetNetworkModel.fromMap(Map<String, dynamic> json) => GetNetworkModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(
          json["data"]?.map((x) => Datum.fromMap(x)) ?? [],
        ),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data?.map((x) => x.toMap()).toList(),
      };
}

class Datum {
  int? id;
  String? image;
  int? airtime;
  int? data; // Update this line
  String? name;
  String? airtimeDiscount;
  String? airtimeMinimum;

  Datum({
    this.id,
    this.image,
    this.airtime,
    this.data,
    this.name,
    this.airtimeDiscount,
    this.airtimeMinimum,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        image: json["image"],
        airtime: json["airtime"],
        data: json["data"],
        name: json["name"],
        airtimeDiscount: json["airtime_discount"],
        airtimeMinimum: json["airtime_minimum"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "airtime": airtime,
        "data": data,
        "name": name,
        "airtime_discount": airtimeDiscount,
        "airtime_minimum": airtimeMinimum,
      };
}
