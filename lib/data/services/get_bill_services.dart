import 'package:dio/dio.dart' show Response;

import 'dio_mixin.dart';

class GetBills with DioMixin {
  Future<Response<dynamic>> getNetworks() async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).get(
      '/bills/networks',
    );
    return response;
  }

  Future<Response<dynamic>> getDataPlans(
    String networkID,
  ) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).get(
      'bills/data/plans?network=$networkID',
    );
    return response;
  }

  Future<Response<dynamic>> getCableDecoders() async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).get(
      '/bills/cables',
    );
    return response;
  }

  Future<Response<dynamic>> getCablePlans(
    num cableID,
  ) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).get(
      '/bills/cable/plans?cable=1',
    );
    return response;
  }

  Future<Response<dynamic>> getPower() async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).get(
      '/bills/powers',
    );
    return response;
  }
}
