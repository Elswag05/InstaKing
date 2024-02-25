import 'package:dio/dio.dart' show Options, Response;

import 'dio_mixin.dart';

class GeneralAccountsServices with DioMixin {
  Future<Response<dynamic>> generateAccountDetails() async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await connect(customHeaders: customHeaders)
        .get('/user/generate-account',
            options: Options(
              method: 'GET',
            ));
    //debugPrint('Info: Service has ${response.data}');
    return response;
  }

  Future<Response<dynamic>> getBanks() async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).get(
      '/user/banks',
    );
    return response;
  }
}
