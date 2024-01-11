import 'package:dio/dio.dart' show Response;

import 'dio_mixin.dart';

class PayBills with DioMixin {
  Future<Response<dynamic>> buyAirtime(
    String network,
    String phone,
    num amount,
  ) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).post(
      '/bills/airtime',
      data: {
        "network": network,
        "phone": phone,
        "amount": amount,
      },
    );
    return response;
  }

  Future<Response<dynamic>> buyData(
    String network,
    String phone,
    String type,
    String plan,
  ) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).post(
      '/bills/data',
      data: {
        "network": network,
        "phone": phone,
        "type": type,
        "plan": plan,
      },
    );
    return response;
  }

  Future<Response<dynamic>> cableValidation(
    num cableID,
    String number,
  ) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).post(
      '/bills/cable/validation',
      data: {
        "cable": cableID, // cable id
        "number": number // decoder number
      },
    );
    return response;
  }

  Future<Response<dynamic>> cablePurchase(
    num cablePlanID,
    String number,
    String cable,
    String customerName,
  ) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).post(
      '/bills/cable',
      data: {
        "cable_plan": cablePlanID, // cable plan id
        "number": number, // decoder number
        "cable": cable, // cable decoder id
        "customer_name": customerName, // gotten from cable validation
      },
    );
    return response;
  }

  Future<Response<dynamic>> buyPower(
    num discoID,
    String number,
    String type,
    num amount,
    String customerName,
  ) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).post(
      '/bills/power',
      data: {
        "disco": discoID,
        "number": number,
        "type": type,
        "amount": amount,
        "customer_name": customerName,
      },
    );
    return response;
  }

  Future<Response<dynamic>> meterValidation(
    num discoID,
    String meterType,
    String meterNumber,
  ) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).post(
      '/bills/power/validation',
      data: {
        "disco": discoID, // disco id
        "meter_type": meterType, //postpaid or prepaid
        "meter_number": meterNumber,
      },
    );
    return response;
  }
}
