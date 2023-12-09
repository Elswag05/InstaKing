import 'package:dio/dio.dart' show Response;
import 'package:flutter/foundation.dart';

import 'dio_mixin.dart';

class LoginService with DioMixin {
  Future<Response<dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    // Use the configured Dio instance from the mixin
    final response = await connect(customHeaders: customHeaders).post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    debugPrint(response.data);
    return response;
  }
}

class SignOutService with DioMixin {
  Future<Response<dynamic>> logOut() async {
    final header = {
      'Accept': 'application/json',
    };
    final response = await connect(customHeaders: header).get('/user/logout');
    return response;
  }
}

class ChangePasswordService with DioMixin {
  Future<Response<dynamic>> changePassword({
    required old_password,
    required new_password,
  }) async {
    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: header).put(
      '/user/update-password',
      data: {
        "old_password": old_password,
        "new_password": new_password,
      },
    );

    return response;
  }
}

class ResetPasswordService with DioMixin {
  Future<Response<dynamic>> resetPassword({
    required email,
    required username,
  }) async {
    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: header).post(
      '/auth/reset-password',
      data: {
        "email": email,
        "username": username,
      },
    );

    return response;
  }
}
