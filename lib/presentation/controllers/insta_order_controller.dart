import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/data/services/order_services.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/get_all_order_model.dart';
import 'package:insta_king/presentation/model/get_order_details_model.dart';
import 'package:insta_king/presentation/model/place_order_model.dart';
import 'package:oktoast/oktoast.dart';

final instaOrderController =
    ChangeNotifierProvider<OrderController>((ref) => OrderController());

class OrderController extends BaseChangeNotifier {
  final PlaceOrder placeOrder = PlaceOrder();
  final GetOrders getOrder = GetOrders();
  final GetOrderDetails getOrderDetails = GetOrderDetails();
  late GetAllOrderModel getAllOrderModel = GetAllOrderModel();
  late PlaceOrderModel placeOrderModel = PlaceOrderModel();
  late final List<String> neededServiceIds;

  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  void disposeOrders() {
    getAllOrderModel.data = [];
    placeOrderModel = PlaceOrderModel();
    neededServiceIds = [];
  }

  Future<bool> toPlaceOrder(
      String serviceId, String link, String quantity) async {
    try {
      loadingState = LoadingState.loading;
      debugPrint('$loadingState');
      final res = await placeOrder.placeOrder(serviceId, link, quantity);
      if (res.statusCode == 201) {
        debugPrint("INFO: Bearer ${res.data}");
        placeOrderModel = PlaceOrderModel.fromJson(res.data);
        loadingState = LoadingState.idle;
        return true;
      } else {
        debugPrint('${res.statusMessage}');
        debugPrint('${res.statusCode}');
        debugPrint(res.toString());
        throw Error();
      }
    } on DioException catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
    } catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
    }
    return false;
  }

  List<Datum> getOrdersByStatus(Status status) {
    if (getAllOrderModel.data == null) return [];
    return getAllOrderModel.data!
        .where((order) => order.status == status)
        .toList();
  }

  Future<List<String>> getAllOrderIds() async {
    try {
      if (getAllOrderModel.data == null) {
        showToast('Please go back and try again!');
      }
      neededServiceIds = getAllOrderModel.data!
          .map((order) => order.serviceId.toString())
          .toList();
      return neededServiceIds;
    } catch (e) {
      log('Error getting order IDs');
      ErrorService.handleErrors(e);
      return [];
    }
  }

  Future<bool> toGetAllOrders() async {
    if (getAllOrderModel.data == [] || getAllOrderModel.data == null) {
      try {
        // loadingState = LoadingState.loading;
        final res = await getOrder.getAllOrders();
        if (res.statusCode == 200 || res.statusCode == 201) {
          getAllOrderModel = GetAllOrderModel.fromJson(res.data);
          debugPrint('All orders so far have been gotten');
          // loadingState = LoadingState.idle;
          return true;
        } else {
          log('All orders not gotten');
          throw Error();
        }
      } on DioException catch (e) {
        loadingState = LoadingState.error;
        ErrorService.handleErrors(e);
      } catch (e) {
        loadingState = LoadingState.error;
        ErrorService.handleErrors(e);
      }
    } else {
      return true;
    }
    return false;
  }

  Future<bool> toGetOrderDetails(orderId) async {
    try {
      // loadingState = LoadingState.loading;
      final res =
          await getOrderDetails.getFilteredOrderDetails(orderId: orderId);
      if (res.statusCode == 200) {
        final data = GetOrderDetailsModel.fromJson(res.data);
        // loadingState = LoadingState.idle;
        if (data.status == 'success') {
          return true;
        }
      } else {
        throw Error();
      }
    } on DioException catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
    } catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
    }
    return false;
  }
}
