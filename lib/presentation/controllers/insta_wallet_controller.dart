import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/data/services/insta_wallet_services.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/insta_wallet_model.dart';
import 'package:insta_king/presentation/model/profile_model.dart';

final instaWalletController = ChangeNotifierProvider<InstaWalletController>(
    (ref) => InstaWalletController());

class InstaWalletController extends BaseChangeNotifier {
  late bool userHasGeneratedAccount = false;
  final GenerateAccountsService generateAccountsService =
      GenerateAccountsService();
  late GenerateAccountModel model = GenerateAccountModel();
  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());
  final ProfileModel profileModel = ProfileModel();
  late bool accountIsGen = false;

  // Future<bool> checkUserAccountTrue() async {
  //   final value = await locator<SecureStorageService>()
  //       .read(key: 'userHasGeneratedAccount');
  //   debugPrint(value.toString());
  //   debugPrint('User account has been read');
  //   if (value != null) {
  //     userHasGeneratedAccount = true;
  //     notifyListeners(); // Make sure notifyListeners is called here
  //     return true;
  //   } else {
  //     userHasGeneratedAccount = false;
  //     notifyListeners(); // And here
  //     return false;
  //   }
  // }

  // Future setUserHasGenAccountsTrueIfFalse() async {
  //   final value = await locator<SecureStorageService>()
  //       .read(key: 'userHasGeneratedAccount');
  //   if (value != null) {
  //     userHasGeneratedAccount = true;
  //     await locator<SecureStorageService>().write(
  //       key: 'userHasGeneratedAccount',
  //       value: 'true',
  //     );
  //   }
  // }

  Future<bool> checkUserAccounts() async {
    loadingState = LoadingState.loading;
    if (profileModel.user?.virtualBanks == [] ||
        profileModel.user?.virtualBanks?[0].accountName == null) {
      accountIsGen = false;
    } else {
      accountIsGen == true;
      userHasGeneratedAccount = true;
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
}
