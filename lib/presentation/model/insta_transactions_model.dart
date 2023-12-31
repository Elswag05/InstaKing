import 'dart:convert';

class InstaTransactionsModel {
  String? status;
  String? message;
  List<Datum>? data;
  int? total;
  int? currentPage;
  dynamic previousPage;
  String? nextPage;
  int? lastPage;

  InstaTransactionsModel({
    this.status,
    this.message,
    this.data,
    this.total,
    this.currentPage,
    this.previousPage,
    this.nextPage,
    this.lastPage,
  });

  InstaTransactionsModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
    int? total,
    int? currentPage,
    dynamic previousPage,
    String? nextPage,
    int? lastPage,
  }) =>
      InstaTransactionsModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        total: total ?? this.total,
        currentPage: currentPage ?? this.currentPage,
        previousPage: previousPage ?? this.previousPage,
        nextPage: nextPage ?? this.nextPage,
        lastPage: lastPage ?? this.lastPage,
      );

  factory InstaTransactionsModel.fromJson(String str) =>
      InstaTransactionsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InstaTransactionsModel.fromMap(Map<String, dynamic> json) =>
      InstaTransactionsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        total: json["total"],
        currentPage: json["current_page"],
        previousPage: json["previous_page"],
        nextPage: json["next_page"],
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "total": total,
        "current_page": currentPage,
        "previous_page": previousPage,
        "next_page": nextPage,
        "last_page": lastPage,
      };
}

class Datum {
  int? id;
  String? userId;
  String? type;
  Service? service;
  String? status;
  String? code;
  String? amount;
  String? charge;
  String? oldBalance;
  String? newBalance;
  String? message;
  String? response;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Datum({
    this.id,
    this.userId,
    this.type,
    this.service,
    this.status,
    this.code,
    this.amount,
    this.charge,
    this.oldBalance,
    this.newBalance,
    this.message,
    this.response,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Datum copyWith({
    int? id,
    String? userId,
    String? type,
    Service? service,
    String? status,
    String? code,
    String? amount,
    String? charge,
    String? oldBalance,
    String? newBalance,
    String? message,
    String? response,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      Datum(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        type: type ?? this.type,
        service: service ?? this.service,
        status: status ?? this.status,
        code: code ?? this.code,
        amount: amount ?? this.amount,
        charge: charge ?? this.charge,
        oldBalance: oldBalance ?? this.oldBalance,
        newBalance: newBalance ?? this.newBalance,
        message: message ?? this.message,
        response: response ?? this.response,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        service: serviceValues.map[json["service"]]!,
        status: json["status"],
        code: json["code"],
        amount: json["amount"],
        charge: json["charge"],
        oldBalance: json["old_balance"],
        newBalance: json["new_balance"],
        message: json["message"],
        response: json["response"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "service": serviceValues.reverse[service],
        "status": status,
        "code": code,
        "amount": amount,
        "charge": charge,
        "old_balance": oldBalance,
        "new_balance": newBalance,
        "message": message,
        "response": response,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

enum Service { ORDER, REFERRAL }

final serviceValues =
    EnumValues({"order": Service.ORDER, "referral": Service.REFERRAL});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
