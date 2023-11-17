import 'package:dio/dio.dart' show Options, Response;

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
    print('Info: Service has ${response.data}');
    return response;
  }
}
