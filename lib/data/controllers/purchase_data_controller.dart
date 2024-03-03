import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/services/bill_services.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/data/services/get_bill_services.dart';
import 'package:insta_king/data/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/get_data_plan_model.dart';

final instaDataController = ChangeNotifierProvider<PurchaseDataController>(
    (ref) => PurchaseDataController());

class PurchaseDataController extends BaseChangeNotifier {
  final GetBills getBills = GetBills();
  final PayBills payBills = PayBills();
  late GetDataPlanModel getDataPlanModel = GetDataPlanModel();

  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  void disposeData() {
    getDataPlanModel.data = [];
    getDataPlanModel.data == null;
  }

  Future<void> toGetDataPlan(num networkID) async {
    disposeData();
    try {
      debugPrint('To Get Data');
      final res = await getBills.getDataPlans(networkID);
      // log(res.toString());
      debugPrint('Got Data plans');
      if (res.statusCode == 200) {
        // debugPrint("INFO: Bearer ${res.data}");
        debugPrint("INFO: $networkID has data plans has been fetched");
        getDataPlanModel = GetDataPlanModel.fromMap(res.data);
        notifyListeners();
      } else {
        debugPrint(res.toString());
        throw Error();
      }
    } on DioException catch (e) {
      ErrorService.handleErrors(e);
    } catch (e) {
      ErrorService.handleErrors(e);
    }
  }

  Future<bool> toBuyData(
    network,
    phone,
    type,
    plan,
  ) async {
    try {
      loadingState = LoadingState.loading;
      debugPrint('To buy data');
      final res = await payBills.buyData(
        network,
        phone,
        type,
        plan,
      );

      if (res.statusCode == 200 && res.data['status'] == 'success') {
        debugPrint("INFO: Bearer ${res.data}");
        loadingState = LoadingState.idle;
        return true;
      } else {
        debugPrint('${res.statusMessage}');
        debugPrint('${res.statusCode}');
        debugPrint(res.toString());
        loadingState = LoadingState.error;
        throw Error();
      }
    } on DioException catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
      return false;
    } catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
      return false;
    }
  }
}
