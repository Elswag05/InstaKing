import 'dart:async';

import 'package:dio/dio.dart';
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

final instaLoginController =
    ChangeNotifierProvider<LoginController>((ref) => LoginController());

class LoginController extends BaseChangeNotifier {
  late bool rememberMe = false;
  bool get isBoxChecked => rememberMe;

  void toCheckBox(value) {
    rememberMe = !rememberMe;
    print(rememberMe.toString());
    notifyListeners();
  }

  final loginService = LoginService();
  final logOutService = SignOutService();

  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  Future<bool> signIn(String email, password) async {
    loadingState = LoadingState.loading;
    try {
      final res = await loginService.signIn(email: email, password: password);
      if (res.statusCode == 200) {
        final data = InstaLoginModel.fromJson(res.data);
        //print(data);
        await locator<SecureStorageService>().write(
          key: EnvStrings.token,
          value: data.token ?? '',
        );
        // if ( rememberMe) {
        //   await locator<SecureStorageService>().write(key: EnvStrings.us, value: value)
        // }
        loadingState = LoadingState.idle;
        locator<ToastService>().showSuccessToast(
          'Successfully logged you in',
        );
        if (data.status == 'success') {
          return true;
        }
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
        await locator<SecureStorageService>().deleteAll();
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
}
