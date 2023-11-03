// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:insta_king/core/constants/env_strings.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/utils/locator.dart';

mixin DioMixin {
  Dio connect() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://www.affiliate.instaking.store/user-api',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.plain,
    );

    Dio dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? value =
              await locator<SecureStorageService>().read(key: EnvStrings.token);
          if (value != null) {
            options.headers['Authorization'] = "Bearer $value";
          }
          return handler.next(options);
        },
        onError: (DioError e, handler) {
          log('e: $e');
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
      return response;
    } on DioError {
      rethrow;
    } on TimeoutException {
      rethrow;
    } on SocketException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
