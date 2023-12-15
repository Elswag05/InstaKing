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
  dynamic? prevPageUrl;
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

  factory InstaTransactionsModel.fromJson(Map<String, dynamic> json) {
    var linksList = json['links'] as List;
    List<Link> links = linksList.map((link) => Link.fromJson(link)).toList();

    return InstaTransactionsModel(
      currentPage: json['current_page'],
      data: Data.fromJson(json['data']),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: links,
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class Data {
  int status;
  String message;
  Map<String, Transaction> transactions;

  Data({
    required this.status,
    required this.message,
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var transactionsMap = json['transactions'] as Map<String, dynamic>;
    Map<String, Transaction> transactions = transactionsMap.map(
      (key, value) {
        return MapEntry(key, Transaction.fromJson(value));
      },
    );

    return Data(
      status: json['status'],
      message: json['message'],
      transactions: transactions,
    );
  }
}

class Transaction {
  int id;
  int userId;
  int type;
  Service? service;
  int status;
  String code;
  double amount;
  double charge;
  double oldBalance;
  double newBalance;
  String message;
  String response;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.type,
    required this.service,
    required this.status,
    required this.code,
    required this.amount,
    required this.charge,
    required this.oldBalance,
    required this.newBalance,
    required this.message,
    required this.response,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      service: serviceValues.map[json['service']],
      status: json['status'],
      code: json['code'],
      amount: json['amount'],
      charge: json['charge'],
      oldBalance: json['old_balance'],
      newBalance: json['new_balance'],
      message: json['message'],
      response: json['response'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'],
    );
  }
}

class Link {
  dynamic url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}

enum Service { order, referral }

final serviceValues =
    EnumValues({'order': Service.order, 'referral': Service.referral});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
