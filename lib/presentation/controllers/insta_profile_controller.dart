import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/data/services/edit_details_service.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/utils/locator.dart';

final instaProfileController =
    ChangeNotifierProvider<ProfileController>((ref) => ProfileController());

class ProfileController extends BaseChangeNotifier {
  final EditDetailService editDetailService = EditDetailService();
  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  Future<bool> editPersonalDetails(
      String fname, lname, address, phone, country) async {
    loadingState = LoadingState.loading;
    try {
      final res = await editDetailService.editDetails(
          fname: fname,
          lname: lname,
          address: address,
          phone: phone,
          country: country);
      if (res.statusCode == 200) {
        loadingState = LoadingState.idle;
        locator<ToastService>().showSuccessToast(
          'Successful Operation',
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
