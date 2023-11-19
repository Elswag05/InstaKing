import 'dart:convert';

class GetOrderDetailsModel {
  String? status;
  String? message;
  Data? data;

  GetOrderDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  GetOrderDetailsModel copyWith({
    String? status,
    String? message,
    Data? data,
  }) =>
      GetOrderDetailsModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetOrderDetailsModel.fromRawJson(String str) =>
      GetOrderDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetOrderDetailsModel(
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
  int? userId;
  int? categoryId;
  int? serviceId;
  int? apiServiceId;
  int? apiProviderId;
  int? apiOrderId;
  dynamic apiRefillId;
  int? quantity;
  int? price;
  String? link;
  String? username;
  String? comments;
  dynamic hashtags;
  dynamic hashtag;
  dynamic media;
  int? startCounter;
  int? remain;
  int? runs;
  int? interval;
  String? status;
  int? apiOrder;
  int? dripFeed;
  String? dripfeedQuantity;
  dynamic refillStatus;
  dynamic refilledAt;
  dynamic name;
  DateTime? createdAt;
  DateTime? updatedAt;
  Service? service;

  Data({
    this.id,
    this.userId,
    this.categoryId,
    this.serviceId,
    this.apiServiceId,
    this.apiProviderId,
    this.apiOrderId,
    this.apiRefillId,
    this.quantity,
    this.price,
    this.link,
    this.username,
    this.comments,
    this.hashtags,
    this.hashtag,
    this.media,
    this.startCounter,
    this.remain,
    this.runs,
    this.interval,
    this.status,
    this.apiOrder,
    this.dripFeed,
    this.dripfeedQuantity,
    this.refillStatus,
    this.refilledAt,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.service,
  });

  Data copyWith({
    int? id,
    int? userId,
    int? categoryId,
    int? serviceId,
    int? apiServiceId,
    int? apiProviderId,
    int? apiOrderId,
    dynamic apiRefillId,
    int? quantity,
    int? price,
    String? link,
    String? username,
    String? comments,
    dynamic hashtags,
    dynamic hashtag,
    dynamic media,
    int? startCounter,
    int? remain,
    int? runs,
    int? interval,
    String? status,
    int? apiOrder,
    int? dripFeed,
    String? dripfeedQuantity,
    dynamic refillStatus,
    dynamic refilledAt,
    dynamic name,
    DateTime? createdAt,
    DateTime? updatedAt,
    Service? service,
  }) =>
      Data(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        categoryId: categoryId ?? this.categoryId,
        serviceId: serviceId ?? this.serviceId,
        apiServiceId: apiServiceId ?? this.apiServiceId,
        apiProviderId: apiProviderId ?? this.apiProviderId,
        apiOrderId: apiOrderId ?? this.apiOrderId,
        apiRefillId: apiRefillId ?? this.apiRefillId,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        link: link ?? this.link,
        username: username ?? this.username,
        comments: comments ?? this.comments,
        hashtags: hashtags ?? this.hashtags,
        hashtag: hashtag ?? this.hashtag,
        media: media ?? this.media,
        startCounter: startCounter ?? this.startCounter,
        remain: remain ?? this.remain,
        runs: runs ?? this.runs,
        interval: interval ?? this.interval,
        status: status ?? this.status,
        apiOrder: apiOrder ?? this.apiOrder,
        dripFeed: dripFeed ?? this.dripFeed,
        dripfeedQuantity: dripfeedQuantity ?? this.dripfeedQuantity,
        refillStatus: refillStatus ?? this.refillStatus,
        refilledAt: refilledAt ?? this.refilledAt,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        service: service ?? this.service,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        serviceId: json["service_id"],
        apiServiceId: json["api_service_id"],
        apiProviderId: json["api_provider_id"],
        apiOrderId: json["api_order_id"],
        apiRefillId: json["api_refill_id"],
        quantity: json["quantity"],
        price: json["price"],
        link: json["link"],
        username: json["username"],
        comments: json["comments"],
        hashtags: json["hashtags"],
        hashtag: json["hashtag"],
        media: json["media"],
        startCounter: json["start_counter"],
        remain: json["remain"],
        runs: json["runs"],
        interval: json["interval"],
        status: json["status"],
        apiOrder: json["api_order"],
        dripFeed: json["drip_feed"],
        dripfeedQuantity: json["dripfeed_quantity"],
        refillStatus: json["refill_status"],
        refilledAt: json["refilled_at"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "category_id": categoryId,
        "service_id": serviceId,
        "api_service_id": apiServiceId,
        "api_provider_id": apiProviderId,
        "api_order_id": apiOrderId,
        "api_refill_id": apiRefillId,
        "quantity": quantity,
        "price": price,
        "link": link,
        "username": username,
        "comments": comments,
        "hashtags": hashtags,
        "hashtag": hashtag,
        "media": media,
        "start_counter": startCounter,
        "remain": remain,
        "runs": runs,
        "interval": interval,
        "status": status,
        "api_order": apiOrder,
        "drip_feed": dripFeed,
        "dripfeed_quantity": dripfeedQuantity,
        "refill_status": refillStatus,
        "refilled_at": refilledAt,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "service": service?.toJson(),
      };
}

class Service {
  int? id;
  int? categoryId;
  dynamic apiProviderId;
  int? apiServiceId;
  int? manualApi;
  String? name;
  String? description;
  int? min;
  int? max;
  int? price;
  int? status;
  String? type;
  int? dripfeed;
  int? refill;

  Service({
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

  Service copyWith({
    int? id,
    int? categoryId,
    dynamic apiProviderId,
    int? apiServiceId,
    int? manualApi,
    String? name,
    String? description,
    int? min,
    int? max,
    int? price,
    int? status,
    String? type,
    int? dripfeed,
    int? refill,
  }) =>
      Service(
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

  factory Service.fromRawJson(String str) => Service.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Service.fromJson(Map<String, dynamic> json) => Service(
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
