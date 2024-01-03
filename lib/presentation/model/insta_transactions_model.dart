// To parse this JSON data, do
//
//     final instaTransactionsModel = instaTransactionsModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

InstaTransactionsModel instaTransactionsModelFromJson(String str) =>
    InstaTransactionsModel.fromJson(json.decode(str));

String instaTransactionsModelToJson(InstaTransactionsModel data) =>
    json.encode(data.toJson());

class InstaTransactionsModel {
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

  String? status;
  String? message;
  List<Datum>? data;
  int? total;
  int? currentPage;
  dynamic previousPage;
  dynamic nextPage;
  int? lastPage;

  factory InstaTransactionsModel.fromJson(Map<String, dynamic> json) =>
      InstaTransactionsModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        total: json["total"],
        currentPage: json["current_page"],
        previousPage: json["previous_page"],
        nextPage: json["next_page"],
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
        "current_page": currentPage,
        "previous_page": previousPage,
        "next_page": nextPage,
        "last_page": lastPage,
      };

  // CopyWith method to create a new instance with some fields updated
  InstaTransactionsModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
    int? total,
    int? currentPage,
    dynamic previousPage,
    dynamic nextPage,
    int? lastPage,
  }) {
    return InstaTransactionsModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
      total: total ?? this.total,
      currentPage: currentPage ?? this.currentPage,
      previousPage: previousPage ?? this.previousPage,
      nextPage: nextPage ?? this.nextPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}

class Datum {
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

  int? id;
  String? userId;
  String? type;
  String? service;
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        service: json["service"],
        status: json["status"],
        code: json["code"],
        amount: json["amount"],
        charge: json["charge"],
        oldBalance: json["old_balance"],
        newBalance: json["new_balance"],
        message: json["message"],
        response: json["response"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "service": service,
        "status": status,
        "code": code,
        "amount": amount,
        "charge": charge,
        "old_balance": oldBalance,
        "new_balance": newBalance,
        "message": message,
        "response": response,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
      };

  // Method to get formatted created date string
  String formattedCreatedAt() {
    if (createdAt != null) {
      return DateFormat("dd MMM, yyyy hh:mm:ss a").format(createdAt!);
    } else {
      return '';
    }
  }
}
