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

  factory GetAllServicesModel.fromRawJson(String str) =>
      GetAllServicesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllServicesModel.fromJson(Map<String, dynamic> json) =>
      GetAllServicesModel(
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
  String? categoryId;
  String? apiProviderId;
  String? apiServiceId;
  String? manualApi;
  String? name;
  String? description;
  String? min;
  String? max;
  String? price;
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
        status: status ?? this.status,
        type: type ?? this.type,
        dripfeed: dripfeed ?? this.dripfeed,
        refill: refill ?? this.refill,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        status: json["status"],
        type: typeValues.map[json["type"]]!,
        dripfeed: json["dripfeed"],
        refill: json["refill"],
      );

  Map<String, dynamic> toJson() => {
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
        "status": status,
        "type": typeValues.reverse[type],
        "dripfeed": dripfeed,
        "refill": refill,
      };
}

enum Type { COMMENT_LIKES, CUSTOM_COMMENTS, DEFAULT, PACKAGE, SUBSCRIPTIONS }

final typeValues = EnumValues({
  "comment likes": Type.COMMENT_LIKES,
  "custom comments": Type.CUSTOM_COMMENTS,
  "default": Type.DEFAULT,
  "package": Type.PACKAGE,
  "subscriptions": Type.SUBSCRIPTIONS
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
