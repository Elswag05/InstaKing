import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/data/services/insta_wallet_services.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/get_banks_model.dart';
import 'package:insta_king/presentation/model/insta_wallet_model.dart';
import 'package:insta_king/presentation/model/profile_model.dart';
import 'package:insta_king/utils/locator.dart';

final instaWalletController = ChangeNotifierProvider<InstaWalletController>(
    (ref) => InstaWalletController());

class InstaWalletController extends BaseChangeNotifier {
  late bool userHasGeneratedAccount = false;
  final GeneralAccountsServices generateAccountsService =
      GeneralAccountsServices();
  late GenerateAccountModel model = GenerateAccountModel();
  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());
  final ProfileModel profileModel = ProfileModel();
  late GetBanksModel getBanksModel = GetBanksModel();
  late bool accountIsGen = false;

  Future<bool> checkUserAccounts(ref) async {
    try {
      if (ref == [] || ref?[0].accountName == null || ref == null) {
        debugPrint('$ref');
        accountIsGen = false;
        userHasGeneratedAccount = false;
      } else {
        accountIsGen == true;
        userHasGeneratedAccount = true;
      }
    } catch (e) {
      debugPrint('$e');
    }
    return accountIsGen;
  }

  Future<GenerateAccountModel> generateAccountDetails() async {
    loadingState = LoadingState.loading;
    try {
      final res = await generateAccountsService.generateAccountDetails();
      if (res.statusCode == 200) {
        //setUserHasGenAccountsTrueIfFalse();
        userHasGeneratedAccount = true;
        model = GenerateAccountModel.fromJson(res.data);
        log('model: ${model.message}');
        loadingState = LoadingState.idle;
        return model;
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
    return model;
  }

  Future<void> toGetUserBanks() async {
    // loadingState = LoadingState.loading;
    if (getBanksModel.data != null) return;
    try {
      debugPrint('INFO: To Get User Banks');
      final res = await generateAccountsService.getBanks();
      if (res.statusCode == 200) {
        log("INFO: Bearer ${res.data}");
        getBanksModel = GetBanksModel.fromMap(res.data);
        debugPrint("INFO: Done converting Banks data to dart model");
      } else {
        loadingState = LoadingState.idle;
        throw Error();
      }
    } on DioException catch (e) {
      // loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
    } catch (e) {
      // loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
    }
  }

  Future<bool> toVerifyKYC(
    bvn,
    bankCode,
    accountNumber,
  ) async {
    try {
      debugPrint('INFO: To Update User Virtual Account KYC');
      final res = await generateAccountsService.verifyKYC(
        bvn,
        bankCode,
        accountNumber,
      );
      if (res.statusCode == 200 && res.data['status'] == 'success') {
        log("INFO: Bearer ${res.data}");
        locator<ToastService>().showSuccessToast(
          'Your status has been updated!',
        );
        loadingState = LoadingState.idle;
        debugPrint("INFO: User has updated status");
        return true;
      } else {
        loadingState = LoadingState.idle;
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
}
