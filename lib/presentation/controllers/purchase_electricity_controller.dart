import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/services/bill_services.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/data/services/get_bill_services.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/get_power_plan_model.dart';

final instaElectricityController =
    ChangeNotifierProvider<ElectricityBillController>(
        (ref) => ElectricityBillController());

class ElectricityBillController extends BaseChangeNotifier {
  final GetBills getBills = GetBills();
  final PayBills payBills = PayBills();
  late GetPowerPlanModel getPowerPlanModel = GetPowerPlanModel();

  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  void disposeElectricity() {
    getPowerPlanModel.data = [];
  }

  Future<void> toGetPowerPlans() async {
    if (getPowerPlanModel.data != null) return;

    try {
      debugPrint('To Get Airtime');
      final res = await getBills.getNetworks();

      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer ${res.data}");
        getPowerPlanModel = GetPowerPlanModel.fromJson(res.data.toString());
      } else {
        debugPrint('${res.statusMessage}');
        debugPrint('${res.statusCode}');
        debugPrint(res.toString());
        throw Error();
      }
    } on DioException catch (e) {
      ErrorService.handleErrors(e);
    } catch (e) {
      ErrorService.handleErrors(e);
    }
  }

  Future<bool> tovalidateUserEligibiity(
    discoID,
    meterType,
    meterNumber,
  ) async {
    try {
      loadingState = LoadingState.loading;
      debugPrint('To validate electricity');
      final res =
          await payBills.meterValidation(discoID, meterType, meterNumber);

      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer ${res.data}");
        loadingState = LoadingState.idle;
        return true;
      } else {
        loadingState = LoadingState.error;
        debugPrint(res.toString());
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

  Future<bool> toPurchaseElectricity(
    discoID,
    number,
    type,
    amount,
    customerName,
    phone,
  ) async {
    try {
      loadingState = LoadingState.loading;
      debugPrint('To Purchase Electricity');
      final res = await payBills.buyPower(
        discoID,
        number,
        type,
        amount,
        customerName,
      );

      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer ${res.data}");
        loadingState = LoadingState.idle;
        return true;
      } else {
        loadingState = LoadingState.error;
        debugPrint('${res.statusMessage}');
        debugPrint('${res.statusCode}');
        debugPrint(res.toString());
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
