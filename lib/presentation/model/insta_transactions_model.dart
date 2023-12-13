import 'dart:convert';

class InstaTransactions {
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

  InstaTransactions({
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

  InstaTransactions copyWith({
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
      InstaTransactions(
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

  factory InstaTransactions.fromRawJson(String str) =>
      InstaTransactions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InstaTransactions.fromJson(Map<String, dynamic> json) =>
      InstaTransactions(
        currentPage: json["current_page"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data?.toJson(),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
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

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        the0: json["0"] == null ? null : The0.fromJson(json["0"]),
        the1: json["1"] == null ? null : The0.fromJson(json["1"]),
        the2: json["2"] == null ? null : The0.fromJson(json["2"]),
        the3: json["3"] == null ? null : The0.fromJson(json["3"]),
        the4: json["4"] == null ? null : The0.fromJson(json["4"]),
        the5: json["5"] == null ? null : The0.fromJson(json["5"]),
        the6: json["6"] == null ? null : The0.fromJson(json["6"]),
        the7: json["7"] == null ? null : The0.fromJson(json["7"]),
        the8: json["8"] == null ? null : The0.fromJson(json["8"]),
        the9: json["9"] == null ? null : The0.fromJson(json["9"]),
        the10: json["10"] == null ? null : The0.fromJson(json["10"]),
        the11: json["11"] == null ? null : The0.fromJson(json["11"]),
        the12: json["12"] == null ? null : The0.fromJson(json["12"]),
        the13: json["13"] == null ? null : The0.fromJson(json["13"]),
        the14: json["14"] == null ? null : The0.fromJson(json["14"]),
        the15: json["15"] == null ? null : The0.fromJson(json["15"]),
        the16: json["16"] == null ? null : The0.fromJson(json["16"]),
        the17: json["17"] == null ? null : The0.fromJson(json["17"]),
        the18: json["18"] == null ? null : The0.fromJson(json["18"]),
        the19: json["19"] == null ? null : The0.fromJson(json["19"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0?.toJson(),
        "1": the1?.toJson(),
        "2": the2?.toJson(),
        "3": the3?.toJson(),
        "4": the4?.toJson(),
        "5": the5?.toJson(),
        "6": the6?.toJson(),
        "7": the7?.toJson(),
        "8": the8?.toJson(),
        "9": the9?.toJson(),
        "10": the10?.toJson(),
        "11": the11?.toJson(),
        "12": the12?.toJson(),
        "13": the13?.toJson(),
        "14": the14?.toJson(),
        "15": the15?.toJson(),
        "16": the16?.toJson(),
        "17": the17?.toJson(),
        "18": the18?.toJson(),
        "19": the19?.toJson(),
        "status": status,
        "message": message,
      };
}

class The0 {
  int? id;
  int? userId;
  String? type;
  Service? service;
  int? status;
  String? code;
  int? amount;
  int? charge;
  double? oldBalance;
  double? newBalance;
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
    int? userId,
    String? type,
    Service? service,
    int? status,
    String? code,
    int? amount,
    int? charge,
    double? oldBalance,
    double? newBalance,
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

  factory The0.fromRawJson(String str) => The0.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory The0.fromJson(Map<String, dynamic> json) => The0(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        service: serviceValues.map[json["service"]]!,
        status: json["status"],
        code: json["code"],
        amount: json["amount"],
        charge: json["charge"],
        oldBalance: json["old_balance"]?.toDouble(),
        newBalance: json["new_balance"]?.toDouble(),
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

  Map<String, dynamic> toJson() => {
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

enum Service { AIRTIME, DATA, ELECTRICITY, ORDER }

final serviceValues = EnumValues({
  "airtime": Service.AIRTIME,
  "data": Service.DATA,
  "electricity": Service.ELECTRICITY,
  "order": Service.ORDER
});

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

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
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
