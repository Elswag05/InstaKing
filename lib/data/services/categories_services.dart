import 'package:dio/dio.dart' show Response;
import 'package:flutter/material.dart';
import 'dio_mixin.dart';

///This is to get all categories. It returns a rather short response in this form  id, name, and two other things
class CategoriesService with DioMixin {
  Future<Response<dynamic>> getAllCategories() async {
    final customHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    // Use the configured Dio instance from the mixin
    final response = await connect(customHeaders: customHeaders).get(
      '/services/categories',
    );

    return response;
  }
}

///This returns the categories in a more ordered manner.

class GetCategoriesService with DioMixin {
  Future<Response<dynamic>> getSpecificCategoriesServices(
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
    debugPrint(response.data.toString());
    return response;
  }
}

///this returns all the services you van get in no ordered manner
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
    //debugPrint('${response.data}');
    return response;
  }
}

///this folters the service.
///Different ID's have different plans. ie Twitter comment is different from Twitter likes
class GetOneServiceDetails with DioMixin {
  Future<Response<dynamic>> getOneServicesDetails(String serviceId) async {
    final customHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Connection': 'keep-alive',
    };
    // Use the configured Dio instance from the mixin
    final response = await connect(customHeaders: customHeaders).get(
      '/services/{$serviceId}',
    );
    debugPrint('${response.data}');
    return response;
  }
}
