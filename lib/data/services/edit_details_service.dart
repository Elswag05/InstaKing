import 'package:dio/dio.dart' show Response;

import 'dio_mixin.dart';

class EditDetailService with DioMixin {
  Future<Response<dynamic>> editDetails({
    required String fname,
    required String lname,
    required String address,
    required String phone,
    required String country,
  }) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final response = await connect(customHeaders: customHeaders).put(
      '/user/profile',
      data: {
        "fname": fname,
        "lname": lname,
        "address": address,
        "phone": phone,
        "country": country
      },
    );
    print(response.data);
    return response;
  }
}
