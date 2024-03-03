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
import 'package:insta_king/data/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/bet_plans_model.dart';
import 'package:oktoast/oktoast.dart';

final instaBetController =
    ChangeNotifierProvider<BetController>((ref) => BetController());

class BetController extends BaseChangeNotifier {
  final GetBills getBills = GetBills();
  final PayBills payBills = PayBills();
  late String userName = '';
  String message = '';
  String newToken = '';
  late BetPlansModel betPlansModel = BetPlansModel();

  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  void disposeElectricity() {
    betPlansModel.data = [];
  }

  ///This is used to get the bet
  ///providers and their respective data
  Future<void> toGetBetPlans() async {
    if (betPlansModel.data != null) return;

    try {
      debugPrint('To Get Bet Plans');
      final res = await getBills.getBetPlans();

      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer ${res.data}");
        betPlansModel = BetPlansModel.fromMap(res.data);
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

  ///Here we validate
  ///the users bet details to see if they are correct
  Future<bool> tovalidateBetData(
    num betPlatformID,
    String betAccountNumber,
  ) async {
    try {
      loadingState = LoadingState.loading;
      debugPrint('To validate bet data');
      final res = await payBills.betAccountValidation(
        betPlatformID,
        betAccountNumber,
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

  Future<bool> toBuyBetMoney(
    int betPlatformId,
    String accountNumber,
    num amount,
    String customerName,
  ) async {
    try {
      loadingState = LoadingState.loading;
      debugPrint('To Purchase Bet Money  && $customerName');
      final res = await payBills.buyBetMoney(
        betPlatformId,
        accountNumber,
        amount,
        customerName,
      );
      debugPrint("INFO: Bet 000");
      if (res.statusCode == 200 && res.data['status'] == 'success') {
        debugPrint("INFO: Bearer ${res.data}");
        Map<String, dynamic> parsedData = jsonDecode(res.toString());
        message = parsedData['message'];
        // newToken = extractToken(message);
        notifyListeners();
        loadingState = LoadingState.idle;
        return true;
      } else {
        loadingState = LoadingState.idle;
        debugPrint("INFO: Bet 003");
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
