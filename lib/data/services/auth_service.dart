import 'package:dio/dio.dart' show Response;

import 'dio_mixin.dart';

class AuthService with DioMixin {
  Future<Response<dynamic>> auth({
    required String googleId,
    required String email,
    required String picture,
    required String name,
  }) async {
    return await sendRequest(() {
      return connect().post('/auth', data: {
        "googleId": googleId,
        "email": email,
        "picture": picture,
        "name": name,
      });
    });
  }
}
