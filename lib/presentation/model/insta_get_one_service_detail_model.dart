import 'dart:convert';

class GetOneServiceDetailsModel {
  String? status;
  String? message;
  Data? data;

  GetOneServiceDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  GetOneServiceDetailsModel copyWith({
    String? status,
    String? message,
    Data? data,
  }) =>
      GetOneServiceDetailsModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetOneServiceDetailsModel.fromRawJson(String str) =>
      GetOneServiceDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetOneServiceDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetOneServiceDetailsModel(
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
  String? type;
  String? dripfeed;
  String? refill;

  Data({
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

  Data copyWith({
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
    String? type,
    String? dripfeed,
    String? refill,
  }) =>
      Data(
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

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        type: json["type"],
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
        "type": type,
        "dripfeed": dripfeed,
        "refill": refill,
      };
}
