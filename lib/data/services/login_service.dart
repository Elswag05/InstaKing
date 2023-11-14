import 'package:dio/dio.dart' show Response;

import 'dio_mixin.dart';

class LoginService with DioMixin {
  Future<Response<dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    return await sendRequest(() {
      return connect().post(
        '/auth/login',
        data: {
          "email": email,
          "password": password,
        },

        // options: Options(
        //     //   headers: {
        //     //   'Accept': 'application/json',
        //     //   'Content-Type': 'application/json',
        //     // },
        //     method: 'POST'),
      );
    });
  }
}
