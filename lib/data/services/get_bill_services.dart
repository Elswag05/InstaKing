import 'package:dio/dio.dart' show Response;

import 'dio_mixin.dart';

class GetBills with DioMixin {
  ///To get the networks available and their corresponding ID
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

  ///To get the data plans available based on the provided networks
  Future<Response<dynamic>> getDataPlans(
    num networkID,
  ) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).get(
      '/bills/data/plans?network=$networkID',
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
      '/bills/cable/plans?cable=$cableID',
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

  Future<Response<dynamic>> getBetPlans() async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).get(
      '/bills/betplans',
    );
    return response;
  }
}
