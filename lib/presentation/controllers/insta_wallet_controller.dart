import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/data/services/insta_wallet_services.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/insta_wallet_model.dart';
import 'package:insta_king/utils/locator.dart';

final instaWalletController = ChangeNotifierProvider<InstaWalletController>(
    (ref) => InstaWalletController());

class InstaWalletController extends BaseChangeNotifier {
  late bool userHasGeneratedAccount = false;
  final GenerateAccountsService generateAccountsService =
      GenerateAccountsService();
  late GenerateAccountModel model = GenerateAccountModel();
  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  Future<bool> checkUserAccountTrue() async {
    final value = await locator<SecureStorageService>()
        .read(key: 'userHasGeneratedAccount');
    debugPrint(value.toString());
    debugPrint('User account has been read');
    if (value != null) {
      userHasGeneratedAccount = true;
      notifyListeners();
      return true;
    } else {
      userHasGeneratedAccount = false;
      notifyListeners();
      return false;
    }
  }

  Future setUserHasGenAccountsTrueIfFalse() async {
    final value = await locator<SecureStorageService>()
        .read(key: 'userHasGeneratedAccount');
    if (value != null) {
      userHasGeneratedAccount = true;
      await locator<SecureStorageService>().write(
        key: 'userHasGeneratedAccount',
        value: 'true',
      );
    }
  }

  Future<GenerateAccountModel> generateAccountDetails() async {
    loadingState = LoadingState.loading;
    try {
      final res = await generateAccountsService.generateAccountDetails();
      if (res.statusCode == 200) {
        setUserHasGenAccountsTrueIfFalse();
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
}
