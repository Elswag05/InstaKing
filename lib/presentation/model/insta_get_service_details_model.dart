// ignore_for_file: constant_identifier_names

import 'dart:convert';

class GetAllServicesModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetAllServicesModel({
    this.status,
    this.message,
    this.data,
  });

  GetAllServicesModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
  }) =>
      GetAllServicesModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetAllServicesModel.fromJson(Map<String, dynamic> json) =>
      GetAllServicesModel.fromMap(json);

  String toJson() => json.encode(toMap());

  factory GetAllServicesModel.fromMap(Map<String, dynamic> json) =>
      GetAllServicesModel(
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
  String? categoryId;
  String? apiProviderId;
  String? apiServiceId;
  String? manualApi;
  String? name;
  String? description;
  String? min;
  String? max;
  String? price;
  SType? sType;
  String? status;
  Type? type;
  String? dripfeed;
  String? refill;

  Datum({
    this.id,
    this.categoryId,
    this.apiProviderId,
    this.apiServiceId,
    this.manualApi,
    this.name,
    this.description,
    this.min,
    this.max,
    this.price,
    this.sType,
    this.status,
    this.type,
    this.dripfeed,
    this.refill,
  });

  Datum copyWith({
    int? id,
    String? categoryId,
    String? apiProviderId,
    String? apiServiceId,
    String? manualApi,
    String? name,
    String? description,
    String? min,
    String? max,
    String? price,
    SType? sType,
    String? status,
    Type? type,
    String? dripfeed,
    String? refill,
  }) =>
      Datum(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        apiProviderId: apiProviderId ?? this.apiProviderId,
        apiServiceId: apiServiceId ?? this.apiServiceId,
        manualApi: manualApi ?? this.manualApi,
        name: name ?? this.name,
        description: description ?? this.description,
        min: min ?? this.min,
        max: max ?? this.max,
        price: price ?? this.price,
        sType: sType ?? this.sType,
        status: status ?? this.status,
        type: type ?? this.type,
        dripfeed: dripfeed ?? this.dripfeed,
        refill: refill ?? this.refill,
      );

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        categoryId: json["category_id"],
        apiProviderId: json["api_provider_id"],
        apiServiceId: json["api_service_id"],
        manualApi: json["manual_api"],
        name: json["name"],
        description: json["description"],
        min: json["min"],
        max: json["max"],
        price: json["price"],
        sType: sTypeValues.map[json["s_type"]],
        status: json["status"],
        type: typeValues.map[json["type"]],
        dripfeed: json["dripfeed"],
        refill: json["refill"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "api_provider_id": apiProviderId,
        "api_service_id": apiServiceId,
        "manual_api": manualApi,
        "name": name,
        "description": description,
        "min": min,
        "max": max,
        "price": price,
        "s_type": sTypeValues.reverse[sType],
        "status": status,
        "type": typeValues.reverse[type],
        "dripfeed": dripfeed,
        "refill": refill,
      };
}

enum SType { NORMAL, SPECIAL }

final sTypeValues =
    EnumValues({"normal": SType.NORMAL, "special": SType.SPECIAL});

enum Type { COMMENT_LIKES, CUSTOM_COMMENTS, DEFAULT, PACKAGE }

final typeValues = EnumValues({
  "comment_likes": Type.COMMENT_LIKES,
  "custom_comments": Type.CUSTOM_COMMENTS,
  "default": Type.DEFAULT,
  "package": Type.PACKAGE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
