import 'dart:async';
import 'dart:convert';

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
import 'package:oktoast/oktoast.dart';

final instaElectricityController =
    ChangeNotifierProvider<ElectricityBillController>(
        (ref) => ElectricityBillController());

class ElectricityBillController extends BaseChangeNotifier {
  final GetBills getBills = GetBills();
  final PayBills payBills = PayBills();
  late String userName = '';
  String message = '';
  String newToken = '';
  late GetPowerPlanModel getPowerPlanModel = GetPowerPlanModel();

  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  void disposeElectricity() {
    getPowerPlanModel.data = [];
  }

  Future<void> toGetPowerPlans() async {
    if (getPowerPlanModel.data != null) return;

    try {
      debugPrint('To Get Electricity');
      final res = await getBills.getPower();

      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer ${res.data}");
        getPowerPlanModel = GetPowerPlanModel.fromMap(res.data);
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

  Future<bool> tovalidateUserEligibiity(
    num discoID,
    String meterType,
    String meterNumber,
  ) async {
    try {
      loadingState = LoadingState.loading;
      debugPrint('To validate electricity');
      final res = await payBills.meterValidation(
        discoID,
        meterType,
        meterNumber,
      );
      Map<String, dynamic> response = res.data;
      debugPrint(res.data.toString());
      if (res.statusCode == 200 && response['status'] == "success") {
        debugPrint("INFO: Successful validation");
        userName = response['name'];
        loadingState = LoadingState.idle;
        return true;
      } else {
        loadingState = LoadingState.idle;
        debugPrint('${res.toString()} just getting started homie');
        throw Error();
      }
    } on DioException catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
      return false;
    } catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
      return false;
    }
  }

  Future<bool> toPurchaseElectricity(
    num discoID,
    String number,
    String type,
    num amount,
    String customerName,
  ) async {
    try {
      loadingState = LoadingState.loading;
      debugPrint('To Purchase Electricity  && $customerName');
      final res = await payBills.buyPower(
        discoID,
        number,
        type,
        amount,
        customerName,
      );
      // debugPrint("INFO: Bearer ${res.data} ");
      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer ${res.data}");
        Map<String, dynamic> parsedData = jsonDecode(res.toString());
        message = parsedData['message'];
        // Find the index of "Token :"
        int startIndex = message.indexOf("Token :");
        notifyListeners();
        // Check if "Token :" is found in the string
        if (startIndex != -1) {
          // Extract the token substring
          String tokenSubstring = message.substring(startIndex);

          // Split the substring by spaces and get the second part (the actual token)
          List<String> tokenParts = tokenSubstring.split(' ');
          String token = tokenParts.length > 1 ? tokenParts[1] : "";
          newToken = "Token: $token";
          debugPrint(newToken);
        } else {
          debugPrint("Token not found in the message.");
        }

        loadingState = LoadingState.idle;
        return true;
      } else {
        loadingState = LoadingState.idle;
        // debugPrint('${res.statusMessage}');
        // debugPrint('${res.statusCode}');
        debugPrint(res.toString());
        Map<String, dynamic> errorParsedData = jsonDecode(res.toString());
        message = errorParsedData['message'];
        showToast(message);
        return false;
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
