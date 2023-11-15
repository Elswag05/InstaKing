import 'dart:convert';

import 'package:dio/dio.dart' show Response;

import 'dio_mixin.dart';

class SignUpService with DioMixin {
  Future<Response<dynamic>> signUp({
    required String email,
    required String firstName,
    required String lastName,
    required String userName,
    required String phone,
    required String password,
    required String referralID,
  }) async {
    final customHeaders = {
      'Accept': 'application/json',
    };
    final response = await connect(customHeaders: customHeaders).post(
      '/auth/signup',
      data: json.encode({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'username': userName,
        'password': password,
        'phone': phone,
        'referral_code': referralID,
      }),
    );
    return response;
  }
}
