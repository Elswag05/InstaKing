import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  bool get isBoxChecked => _rememberMe;

  void toCheckBox(value) {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  final loginService = LoginService();
  final logOutService = SignOutService();
  final changePasswordService = ChangePasswordService();
  final resetPasswordService = ResetPasswordService();
  late InstaLoginModel data;
  final LocalAuthentication _localAuthentication = LocalAuthentication();

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
        await locator<SecureStorageService>().write(
          key: 'loggedIn',
          value: 'true',
        );

        if (_rememberMe) {
          debugPrint(_rememberMe.toString());
          await locator<SecureStorageService>().write(
            key: InstaStrings.email,
            value: data.user?.email ?? '',
          );
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
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
    } catch (e) {
      loadingState = LoadingState.error;
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
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
    } catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
    }
    return false;
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    loadingState = LoadingState.loading;
    try {
      final res = await changePasswordService.changePassword(
        old_password: oldPassword,
        new_password: newPassword,
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
        loadingState = LoadingState.idle;
        locator<ToastService>().showSuccessToast(
          'Check your mail to reset password!',
        );
        return true;
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
