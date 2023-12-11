import 'package:dio/dio.dart' show Options, Response;

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
    final response = await connect().post(
      '/auth/signup',
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'username': userName,
        'password': password,
        'phone': phone,
        'referral_code': referralID,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
    return response;
  }
}
