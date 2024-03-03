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
import 'package:insta_king/data/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/get_network_model.dart';

final instaAirtimeController =
    ChangeNotifierProvider<PurchaseAirtimeController>(
        (ref) => PurchaseAirtimeController());

class PurchaseAirtimeController extends BaseChangeNotifier {
  final GetBills getBills = GetBills();
  final PayBills payBills = PayBills();
  late GetNetworkModel getNetworkModel = GetNetworkModel();

  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  void disposeAirtime() {
    getNetworkModel.data = [];
  }

  Future<void> toGetNetworks() async {
    if (getNetworkModel.data != null) return;
    try {
      debugPrint('To Get Airtime');
      final res = await getBills.getNetworks();
      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer ${res.data}");
        getNetworkModel = GetNetworkModel.fromMap(res.data);
        debugPrint("INFO: Done converting network data to dart model");
      } else {
        throw Error();
      }
    } on DioException catch (e) {
      ErrorService.handleErrors(e);
    } catch (e) {
      ErrorService.handleErrors(e);
    }
  }

  Future<bool> toPurchaseAirtime(
    network,
    phone,
    amount,
  ) async {
    try {
      loadingState = LoadingState.loading;
      debugPrint('To Purchase Airtime');
      final res = await payBills.buyAirtime(
        "3",
        phone,
        amount,
      );

      if (res.statusCode == 200 && res.data['status'] == 'success') {
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
