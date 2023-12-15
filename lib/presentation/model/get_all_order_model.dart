import 'dart:convert';

class GetAllOrderModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetAllOrderModel({
    this.status,
    this.message,
    this.data,
  });

  GetAllOrderModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
  }) =>
      GetAllOrderModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetAllOrderModel.fromRawJson(String str) =>
      GetAllOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllOrderModel.fromJson(Map<String, dynamic> json) =>
      GetAllOrderModel(
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
  String? userId;
  String? categoryId;
  String? serviceId;
  String? apiServiceId;
  String? apiProviderId;
  String? apiOrderId;
  dynamic apiRefillId;
  String? quantity;
  String? price;
  String? amount;
  String? profit;
  String? link;
  String? username;
  Comments? comments;
  dynamic hashtags;
  dynamic hashtag;
  dynamic media;
  String? startCounter;
  String? remain;
  String? runs;
  String? interval;
  Status? status;
  String? apiOrder;
  String? dripFeed;
  String? dripfeedQuantity;
  dynamic refillStatus;
  dynamic refilledAt;
  dynamic name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
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
    this.amount,
    this.profit,
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
  });

  Datum copyWith({
    int? id,
    String? userId,
    String? categoryId,
    String? serviceId,
    String? apiServiceId,
    String? apiProviderId,
    String? apiOrderId,
    dynamic apiRefillId,
    String? quantity,
    String? price,
    String? amount,
    String? profit,
    String? link,
    String? username,
    Comments? comments,
    dynamic hashtags,
    dynamic hashtag,
    dynamic media,
    String? startCounter,
    String? remain,
    String? runs,
    String? interval,
    Status? status,
    String? apiOrder,
    String? dripFeed,
    String? dripfeedQuantity,
    dynamic refillStatus,
    dynamic refilledAt,
    dynamic name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Datum(
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
        amount: amount ?? this.amount,
        profit: profit ?? this.profit,
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
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        amount: json["amount"],
        profit: json["profit"],
        link: json["link"],
        username: json["username"],
        comments: commentsValues.map[json["comments"]]!,
        hashtags: json["hashtags"],
        hashtag: json["hashtag"],
        media: json["media"],
        startCounter: json["start_counter"],
        remain: json["remain"],
        runs: json["runs"],
        interval: json["interval"],
        status: statusValues.map[json["status"]]!,
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
        "amount": amount,
        "profit": profit,
        "link": link,
        "username": username,
        "comments": commentsValues.reverse[comments],
        "hashtags": hashtags,
        "hashtag": hashtag,
        "media": media,
        "start_counter": startCounter,
        "remain": remain,
        "runs": runs,
        "interval": interval,
        "status": statusValues.reverse[status],
        "api_order": apiOrder,
        "drip_feed": dripFeed,
        "dripfeed_quantity": dripfeedQuantity,
        "refill_status": refillStatus,
        "refilled_at": refilledAt,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum Comments { EMPTY, HELP_US }

final commentsValues =
    EnumValues({"": Comments.EMPTY, "Help us": Comments.HELP_US});

enum Status { CANCELED, COMPLETED, INPROGRESS, PENDING, PROCESSING }

final statusValues = EnumValues({
  "canceled": Status.CANCELED,
  "completed": Status.COMPLETED,
  "inprogress": Status.INPROGRESS,
  "pending": Status.PENDING,
  "processing": Status.PROCESSING
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
