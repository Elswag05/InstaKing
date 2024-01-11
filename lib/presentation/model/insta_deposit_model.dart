import 'dart:convert';

class InstaDepositModel {
  String? status;
  String? message;
  List<Datum>? data;
  int? total;
  int? currentPage;
  dynamic previousPage;
  dynamic nextPage;
  int? lastPage;

  InstaDepositModel({
    this.status,
    this.message,
    this.data,
    this.total,
    this.currentPage,
    this.previousPage,
    this.nextPage,
    this.lastPage,
  });

  InstaDepositModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
    int? total,
    int? currentPage,
    dynamic previousPage,
    dynamic nextPage,
    int? lastPage,
  }) =>
      InstaDepositModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        total: total ?? this.total,
        currentPage: currentPage ?? this.currentPage,
        previousPage: previousPage ?? this.previousPage,
        nextPage: nextPage ?? this.nextPage,
        lastPage: lastPage ?? this.lastPage,
      );

  factory InstaDepositModel.fromJson(String str) =>
      InstaDepositModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InstaDepositModel.fromMap(Map<String, dynamic> json) =>
      InstaDepositModel(
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
  String? code;
  String? type;
  String? message;
  int? amount;
  double? finalAmount;
  double? charge;
  String? gateway;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? image;
  String? name;

  Datum({
    this.id,
    this.code,
    this.type,
    this.message,
    this.amount,
    this.finalAmount,
    this.charge,
    this.gateway,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.name,
  });

  Datum copyWith({
    int? id,
    String? code,
    String? type,
    String? message,
    int? amount,
    double? finalAmount,
    double? charge,
    String? gateway,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? image,
    String? name,
  }) =>
      Datum(
        id: id ?? this.id,
        code: code ?? this.code,
        type: type ?? this.type,
        message: message ?? this.message,
        amount: amount ?? this.amount,
        finalAmount: finalAmount ?? this.finalAmount,
        charge: charge ?? this.charge,
        gateway: gateway ?? this.gateway,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        image: image ?? this.image,
        name: name ?? this.name,
      );

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        code: json["code"],
        type: json["type"],
        message: json["message"],
        amount: json["amount"],
        finalAmount: json["final_amount"]?.toDouble(),
        charge: json["charge"]?.toDouble(),
        gateway: json["gateway"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "type": type,
        "message": message,
        "amount": amount,
        "final_amount": finalAmount,
        "charge": charge,
        "gateway": gateway,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image": image,
        "name": name,
      };
}
