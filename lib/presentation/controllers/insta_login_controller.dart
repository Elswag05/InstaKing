import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/core/constants/env_strings.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/data/services/login_service.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/insta_login_model.dart';
import 'package:insta_king/utils/locator.dart';

final instaLoginController =
    ChangeNotifierProvider<LoginController>((ref) => LoginController());

class LoginController extends BaseChangeNotifier {
  final loginService = LoginService();
  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  Future<bool> signIn(String email, password) async {
    loadingState = LoadingState.loading;
    try {
      final res = await loginService.signIn(email: email, password: password);
      if (res.statusCode == 200) {
        final data = InstaLoginModel.fromJson(res.data);
        await locator<SecureStorageService>().write(
          key: EnvStrings.token,
          value: data.token ?? '',
        );
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
