import 'package:dio/dio.dart' show Response;

import 'dio_mixin.dart';

class PlaceOrder with DioMixin {
  Future<Response<dynamic>> placeOrder(
    String serviceId,
    String link,
    String quantity,
  ) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).post(
      '/orders/create',
      data: {
        "service": serviceId,
        "link": link,
        "quantity": quantity,
      },
    );
    return response;
  }
}

class GetOrders with DioMixin {
  ///to get all orders, use await getAllOrdersInstance.getFilteredOrders();
  /// To get orders of a specific type (e.g., 'electronics')
  ///await getAllOrdersInstance.getFilteredOrders(type: 'electronics');
  Future<Response<dynamic>> getAllOrders({String? type}) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };

    final Map<String, dynamic> queryParams = {};

    // Add type to queryParams if provided
    if (type != null) {
      queryParams['type'] = type;
    }

    // Use the configured Dio instance from the mixin
    final response = await connect(customHeaders: customHeaders).get(
      '/orders',
      queryParameters: queryParams,
    );

    return response;
  }
}

class GetOrderDetails with DioMixin {
  Future<Response<dynamic>> getFilteredOrderDetails({String? orderId}) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };

    // Use the configured Dio instance from the mixin
    final response = await connect(customHeaders: customHeaders).get(
      '/orders/$orderId',
    );

    return response;
  }
}
