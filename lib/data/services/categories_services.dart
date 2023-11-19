import 'package:dio/dio.dart' show Response;

import 'dio_mixin.dart';

class CategoriesService with DioMixin {
  Future<Response<dynamic>> getCategories() async {
    final customHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    // Use the configured Dio instance from the mixin
    final response = await connect(customHeaders: customHeaders).get(
      '/services/categories',
    );
    print(response.data);
    return response;
  }
}

//TODO: change the String to int if it does not work
class GetCategoriesService with DioMixin {
  Future<Response<dynamic>> getCategoriesServices(
      {required String categoryId}) async {
    final customHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    // Use the configured Dio instance from the mixin
    final response = await connect(customHeaders: customHeaders).get(
      '/services/category/{$categoryId}',
    );
    print(response.data);
    return response;
  }
}

class GetAllServiceDetails with DioMixin {
  Future<Response<dynamic>> getAllServicesDetails() async {
    final customHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    // Use the configured Dio instance from the mixin
    final response = await connect(customHeaders: customHeaders).get(
      '/services',
    );
    print(response.data);
    return response;
  }
}

class GetOneServiceDetails with DioMixin {
  Future<Response<dynamic>> getOneServicesDetails(String serviceId) async {
    final customHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    // Use the configured Dio instance from the mixin
    final response = await connect(customHeaders: customHeaders).get(
      '/services/$serviceId',
    );
    print(response.data);
    return response;
  }
}
