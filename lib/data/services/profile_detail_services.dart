import 'package:dio/dio.dart' show FormData, Options, Response;
import 'package:flutter/material.dart';

import 'dio_mixin.dart';

class GetProfileService with DioMixin {
  Future<Response<dynamic>> getProfileDetails() async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response =
        await connect(customHeaders: customHeaders).get('/user/profile',
            options: Options(
              method: 'GET',
            ));
    debugPrint('Info: Service has ${response.data}');
    return response;
  }

  Future<Response<dynamic>> setProfilePic({required FormData formData}) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await connect(customHeaders: customHeaders).put(
      '/user/profile',
      data: formData,
    );
    debugPrint('Info: Service has ${response.data}');
    return response;
  }
}
