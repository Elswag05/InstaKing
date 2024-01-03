import 'package:dio/dio.dart' show Response;

import 'dio_mixin.dart';

///Transaction Status

/// 1 = successful/completed
/// 2 = pending
/// 3 = failed/cancelled
/// Send search="value" to search for transactions

class TransactionsService with DioMixin {
  Future<Response<dynamic>> getTransacations() async {
    final customHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    // Use the configured Dio instance from the mixin
    final response = await connect(customHeaders: customHeaders).get(
      '/user/transactions/',
    );

    return response;
  }
}
