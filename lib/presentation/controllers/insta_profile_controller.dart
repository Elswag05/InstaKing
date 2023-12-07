import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/data/services/edit_details_service.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/data/services/profile_detail_services.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/profile_model.dart';
import 'package:insta_king/utils/locator.dart';

final instaProfileController =
    ChangeNotifierProvider<ProfileController>((ref) => ProfileController());

class ProfileController extends BaseChangeNotifier {
  File? image;
  final EditDetailService editDetailService = EditDetailService();
  final GetProfileService _getProfileService = GetProfileService();
  late ProfileModel model = ProfileModel();
  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  void saveGalleryImage(File? galleryImage) {
    image = galleryImage;
  }

  void saveCameraImage(File? cameraImage) {
    image = cameraImage;
  }

  // Future pickImageCamera() async {
  //   Future<Uint8List> imageBytes = image!.readAsBytes();
  //   String baseimage = base64.encode(imageBytes);
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //     if (image == null) return;
  //     final imageTemp = File(image.path);
  //     _pickedFile = PickedFile(image.path);
  //     this.image = imageTemp;
  //     notifyListeners();
  //     try {
  //       final res = await _getProfileService.setProfilePic(image: baseimage);
  //       if (res.statusCode == 200) {
  //         loadingState = LoadingState.idle;
  //         locator<ToastService>().showSuccessToast(
  //           'Profile image set successfully',
  //         );
  //         model = ProfileModel.fromJson(res.data);
  //         notifyListeners();
  //         log('model: ${model.message}');
  //         return model;
  //       } else {
  //         throw Error();
  //       }
  //     } on DioException catch (e) {
  //       loadingState = LoadingState.error;
  //       ErrorService.handleErrors(e);
  //     } catch (e) {
  //       loadingState = LoadingState.error;
  //       ErrorService.handleErrors(e);
  //     }
  //   } on PlatformException catch (e) {
  //     debugPrint('$e');
  //   }
  // }

  Future<ProfileModel> getProfileDetails() async {
    loadingState = LoadingState.loading;
    try {
      final res = await _getProfileService.getProfileDetails();
      if (res.statusCode == 200) {
        loadingState = LoadingState.idle;
        // locator<ToastService>().showSuccessToast(
        //   'Gotten Profile Details',
        // );
        model = ProfileModel.fromJson(res.data);
        notifyListeners();
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

  Future<bool> editPersonalDetails(
    String fname,
    String lname,
    String address,
    String phone,
    String country,
  ) async {
    loadingState = LoadingState.loading;
    try {
      final res = await editDetailService.editDetails(
        fname: fname,
        lname: lname,
        address: address,
        phone: phone,
        country: country,
      );
      print(res.data);
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
