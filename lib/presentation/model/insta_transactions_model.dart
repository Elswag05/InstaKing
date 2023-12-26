import 'dart:convert';

class InstaTransactionsModel {
  int? currentPage;
  Data? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  InstaTransactionsModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  InstaTransactionsModel copyWith({
    int? currentPage,
    Data? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    String? nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      InstaTransactionsModel(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        links: links ?? this.links,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory InstaTransactionsModel.fromJson(String str) =>
      InstaTransactionsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InstaTransactionsModel.fromMap(Map<String, dynamic> json) =>
      InstaTransactionsModel(
        currentPage: json["current_page"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": data?.toMap(),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Data {
  The0? the0;
  The0? the1;
  The0? the2;
  The0? the3;
  The0? the4;
  The0? the5;
  The0? the6;
  The0? the7;
  The0? the8;
  The0? the9;
  The0? the10;
  The0? the11;
  The0? the12;
  The0? the13;
  The0? the14;
  The0? the15;
  The0? the16;
  The0? the17;
  The0? the18;
  The0? the19;
  String? status;
  String? message;

  Data({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.the6,
    this.the7,
    this.the8,
    this.the9,
    this.the10,
    this.the11,
    this.the12,
    this.the13,
    this.the14,
    this.the15,
    this.the16,
    this.the17,
    this.the18,
    this.the19,
    this.status,
    this.message,
  });

  Data copyWith({
    The0? the0,
    The0? the1,
    The0? the2,
    The0? the3,
    The0? the4,
    The0? the5,
    The0? the6,
    The0? the7,
    The0? the8,
    The0? the9,
    The0? the10,
    The0? the11,
    The0? the12,
    The0? the13,
    The0? the14,
    The0? the15,
    The0? the16,
    The0? the17,
    The0? the18,
    The0? the19,
    String? status,
    String? message,
  }) =>
      Data(
        the0: the0 ?? this.the0,
        the1: the1 ?? this.the1,
        the2: the2 ?? this.the2,
        the3: the3 ?? this.the3,
        the4: the4 ?? this.the4,
        the5: the5 ?? this.the5,
        the6: the6 ?? this.the6,
        the7: the7 ?? this.the7,
        the8: the8 ?? this.the8,
        the9: the9 ?? this.the9,
        the10: the10 ?? this.the10,
        the11: the11 ?? this.the11,
        the12: the12 ?? this.the12,
        the13: the13 ?? this.the13,
        the14: the14 ?? this.the14,
        the15: the15 ?? this.the15,
        the16: the16 ?? this.the16,
        the17: the17 ?? this.the17,
        the18: the18 ?? this.the18,
        the19: the19 ?? this.the19,
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        the0: json["0"] == null ? null : The0.fromMap(json["0"]),
        the1: json["1"] == null ? null : The0.fromMap(json["1"]),
        the2: json["2"] == null ? null : The0.fromMap(json["2"]),
        the3: json["3"] == null ? null : The0.fromMap(json["3"]),
        the4: json["4"] == null ? null : The0.fromMap(json["4"]),
        the5: json["5"] == null ? null : The0.fromMap(json["5"]),
        the6: json["6"] == null ? null : The0.fromMap(json["6"]),
        the7: json["7"] == null ? null : The0.fromMap(json["7"]),
        the8: json["8"] == null ? null : The0.fromMap(json["8"]),
        the9: json["9"] == null ? null : The0.fromMap(json["9"]),
        the10: json["10"] == null ? null : The0.fromMap(json["10"]),
        the11: json["11"] == null ? null : The0.fromMap(json["11"]),
        the12: json["12"] == null ? null : The0.fromMap(json["12"]),
        the13: json["13"] == null ? null : The0.fromMap(json["13"]),
        the14: json["14"] == null ? null : The0.fromMap(json["14"]),
        the15: json["15"] == null ? null : The0.fromMap(json["15"]),
        the16: json["16"] == null ? null : The0.fromMap(json["16"]),
        the17: json["17"] == null ? null : The0.fromMap(json["17"]),
        the18: json["18"] == null ? null : The0.fromMap(json["18"]),
        the19: json["19"] == null ? null : The0.fromMap(json["19"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "0": the0?.toMap(),
        "1": the1?.toMap(),
        "2": the2?.toMap(),
        "3": the3?.toMap(),
        "4": the4?.toMap(),
        "5": the5?.toMap(),
        "6": the6?.toMap(),
        "7": the7?.toMap(),
        "8": the8?.toMap(),
        "9": the9?.toMap(),
        "10": the10?.toMap(),
        "11": the11?.toMap(),
        "12": the12?.toMap(),
        "13": the13?.toMap(),
        "14": the14?.toMap(),
        "15": the15?.toMap(),
        "16": the16?.toMap(),
        "17": the17?.toMap(),
        "18": the18?.toMap(),
        "19": the19?.toMap(),
        "status": status,
        "message": message,
      };
}

class The0 {
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

  The0({
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

  The0 copyWith({
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
      The0(
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

  factory The0.fromJson(String str) => The0.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory The0.fromMap(Map<String, dynamic> json) => The0(
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

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
