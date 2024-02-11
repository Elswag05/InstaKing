import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/core/constants/env_strings.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/data/services/login_service.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/insta_login_model.dart';
import 'package:insta_king/utils/locator.dart';
import 'package:local_auth/local_auth.dart';

final instaLoginController =
    ChangeNotifierProvider<LoginController>((ref) => LoginController());

class LoginController extends BaseChangeNotifier {
  late bool _rememberMe = false;

  late bool authenticated = false;
  late bool canCheckBiometrics;

  bool get isBoxChecked => _rememberMe;
  final LocalAuthentication auth = LocalAuthentication();
  late List<BiometricType> availableBiometrics;

  void toCheckBox(value) {
    _rememberMe = value;
    _rememberMe == true
        ? debugPrint('User biometric Auth set to true || $_rememberMe')
        : debugPrint('This value is false || $_rememberMe... Biometric Auth');
    // notifyListeners();
  }

  initBiomLoginAuth() async {
    canCheckBiometrics = await auth.canCheckBiometrics;
    availableBiometrics = await auth.getAvailableBiometrics();
    debugPrint(
        'This device can check for user biometrics == $canCheckBiometrics');
    debugPrint('List of auth available == $availableBiometrics');
  }

  final loginService = LoginService();
  final logOutService = SignOutService();
  final changePasswordService = ChangePasswordService();
  final resetPasswordService = ResetPasswordService();
  late InstaLoginModel data;

  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  Future checkUserHasGenAccountsBefore() async {
    if (data.user?.virtualBanks != []) {
      await locator<SecureStorageService>().write(
        key: 'userHasGeneratedAccount',
        value: 'true',
      );
    }
  }

  Future<bool> toAuthenticate() async {
    try {
      debugPrint('Starting biometric auth process');
      if (canCheckBiometrics == true || availableBiometrics != []) {
        authenticated = await auth.authenticate(
          localizedReason: 'Authenticate to log in',
          options: const AuthenticationOptions(
            stickyAuth: true,
          ),
        );
        debugPrint('User is authenticated ==> $authenticated');
      } else {
        String message = "Sorry! You do not have Biometric unlock available";
        locator<ToastService>().showErrorToast(
          message,
        );
      }
    } on PlatformException catch (e) {
      debugPrint('$e');
      debugPrint(e.code);
      debugPrint('${e.details}');
      debugPrint('${e.message}');
    }
    return authenticated;
  }

  Future setUserToUSeBiometric(emailHere) async {
    try {
      if (_rememberMe) {
        doRememberMe(emailHere);
        toCheckBox(true);
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future removeUserFromBiometric() async {
    try {
      if (!_rememberMe) {
        debugPrint('User detail has been removed from system');
        await locator<SecureStorageService>().delete(key: InstaStrings.email);
        toCheckBox(false);
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  writeLoggedIn() async {
    await locator<SecureStorageService>().write(
      key: 'loggedIn',
      value: 'true',
    );
  }

  doRememberMe(String email) async {
    debugPrint(_rememberMe.toString());
    debugPrint('Remember me logic is called');
    await locator<SecureStorageService>().write(
      key: InstaStrings.email,
      value: email,
    );
  }

  Future<bool> signIn(String email, password) async {
    loadingState = LoadingState.loading;
    try {
      final res = await loginService.signIn(email: email, password: password);
      if (res.statusCode == 200) {
        data = InstaLoginModel.fromJson(res.data);
        await locator<SecureStorageService>().write(
          key: InstaStrings.token,
          value: data.token ?? '',
        );
        writeLoggedIn();
        if (_rememberMe) {
          doRememberMe(data.user?.email ?? '');
        }
        if (data.status == 'error') {
          locator<ToastService>().showSuccessToast(
            '${data.message}',
          );
          return false;
        }
        if (data.status == 'success') {
          locator<ToastService>().showSuccessToast(
            'Successfully logged you in',
          );
          return true;
        }
        loadingState = LoadingState.idle;
      } else {
        throw Error();
      }
    } on DioException catch (e) {
      loadingState = LoadingState.idle;

      ErrorService.handleErrors(e);
    } catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
    }
    return false;
  }

  Future<bool> signOut() async {
    loadingState = LoadingState.loading;
    try {
      final res = await logOutService.logOut();
      if (res.statusCode == 200) {
        loadingState = LoadingState.idle;
        locator<ToastService>().showSuccessToast(
          'You have been successfully logged out',
        );
        return true;
      } else {
        throw Error();
      }
    } on DioException catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
    } catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
    }
    return false;
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    loadingState = LoadingState.loading;
    try {
      final res = await changePasswordService.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      if (res.statusCode == 200) {
        loadingState = LoadingState.idle;
        locator<ToastService>().showSuccessToast(
          'Your Password Has Been Changed',
        );
        return true;
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

  Future<bool> resetPassword(String email, String userName) async {
    loadingState = LoadingState.loading;
    try {
      final res = await resetPasswordService.resetPassword(
        email: email,
        username: userName,
      );
      if (res.statusCode == 200) {
        locator<ToastService>().showSuccessToast(
          'Check your mail to reset password!',
        );
        loadingState = LoadingState.idle;
      } else {
        // throw Error();
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
