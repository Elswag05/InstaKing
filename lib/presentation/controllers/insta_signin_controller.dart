import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/core/constants/env_strings.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/data/services/signup_service.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/insta_signup_model.dart';
import 'package:insta_king/utils/locator.dart';

final instaSignUpController =
    ChangeNotifierProvider<SignUpController>((ref) => SignUpController());

class SignUpController extends BaseChangeNotifier {
  late InstaSignUpModel data;
  late bool checkedBox = false;
  bool get isBoxChecked => checkedBox;

  void toCheckBox(value) {
    checkedBox = !checkedBox;
    debugPrint(checkedBox.toString());
    notifyListeners();
  }

  final signUpService = SignUpService();
  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  Future<bool> signUp(
    String firstName,
    lastName,
    email,
    userName,
    passWord,
    phone,
    referralCode,
  ) async {
    loadingState = LoadingState.loading;
    try {
      final res = await signUpService.signUp(
        email: email,
        firstName: firstName,
        lastName: lastName,
        userName: userName,
        phone: phone,
        password: passWord,
        referralID: referralCode,
      );
      if (res.statusCode == 200) {
        data = InstaSignUpModel.fromJson(res.data);
        await locator<SecureStorageService>().write(
          key: InstaStrings.token,
          value: data.token ?? '',
        );
        if (data.status == 'success') {
          locator<ToastService>().showSuccessToast(
            'You are signed in',
          );
          return true;
        }
        loadingState = LoadingState.idle;
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
