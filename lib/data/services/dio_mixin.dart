// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insta_king/core/constants/env_strings.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/utils/locator.dart';

mixin DioMixin {
  Dio connect({Map<String, dynamic>? customHeaders}) {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://www.instaking.ng/user-api',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json,
    );

    Dio dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? value = await locator<SecureStorageService>()
              .read(key: InstaStrings.token);
          if (value != 'token' && value != null) {
            options.headers['Authorization'] = "Bearer $value";
            debugPrint(value);
          }
          if (customHeaders != null) {
            options.headers.addAll(Map<String, dynamic>.from(customHeaders));
          }
          return handler.next(options);
        },
        onError: (DioError e, handler) {
          log('Dio Error 00: ${e.response}', error: e);
          String message = e.response?.data.toString() ?? '';
          locator<ToastService>().showErrorToast(
            message,
          );
          return handler.next(e);
        },
      ),
    );

    return dio;
  }

  Future<Response<dynamic>> sendRequest(
      Future<Response<dynamic>> Function() request) async {
    try {
      final response = await request();
      debugPrint('Info: work is at ${response.data}');
      return response;
    } on DioError catch (e) {
      // Handle Dio errors (e.g., network issues, non-200 status codes)
      String message = e.message.toString();
      locator<ToastService>().showErrorToast(
        message,
      );
      log('Dio Error 01: $e', error: e);

      rethrow;
    } catch (e) {
      // Handle other errors
      log('Dio Error 02: $e', error: e);
      rethrow;
    }
  }
}
