import 'package:dio/dio.dart' show Options, Response;
import 'package:flutter/material.dart';

import 'dio_mixin.dart';

class GenerateAccountsService with DioMixin {
  Future<Response<dynamic>> generateAccountDetails() async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await connect(customHeaders: customHeaders)
        .get('/user/generate-account',
            options: Options(
              method: 'GET',
            ));
    debugPrint('Info: Service has ${response.data}');
    return response;
  }
}
