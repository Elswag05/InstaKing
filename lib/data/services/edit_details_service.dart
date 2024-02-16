import 'package:dio/dio.dart' show FormData, Options, Response;

import 'dio_mixin.dart';

class EditDetailService with DioMixin {
  Future<Response<dynamic>> editDetails({
    required String fname,
    required String lname,
    required String address,
    required String phone,
    required String country,
  }) async {
    var requestData = <String, String>{
      "fname": fname,
      "lname": lname,
      "address": address,
      "phone": phone,
      "country": country
    };
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await connect(customHeaders: customHeaders).put(
      '/user/profile',
      data: requestData,
    );
    return response;
  }
}
