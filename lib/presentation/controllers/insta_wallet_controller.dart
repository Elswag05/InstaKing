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

final instaWalletController = ChangeNotifierProvider<InstaWalletController>(
    (ref) => InstaWalletController());

class InstaWalletController extends BaseChangeNotifier {
  final GenerateAccountsService generateAccountsService =
      GenerateAccountsService();
  late final GenerateAccountModel model;
  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  Future<GenerateAccountModel> generateAccountDetails() async {
    loadingState = LoadingState.loading;
    try {
      final res = await generateAccountsService.generateAccountDetails();
      if (res.statusCode == 200) {
        loadingState = LoadingState.idle;
        // locator<ToastService>().showSuccessToast(
        //   'Gotten Profile Details',
        // );
        model = GenerateAccountModel.fromJson(res.data);
        log('model: ${model.message}');
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