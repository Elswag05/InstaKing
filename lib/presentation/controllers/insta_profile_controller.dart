import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
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
  String imagePath = '';
  File imageFile = File('');
  Uint8List imageBytes = Uint8List(0);
  String base64String = '';
  final EditDetailService editDetailService = EditDetailService();
  final GetProfileService _getProfileService = GetProfileService();
  late ProfileModel model = ProfileModel();
  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  void saveGalleryImage(File? galleryImage) {
    image = galleryImage;
    notifyListeners();
  }

  void saveCameraImage(File? cameraImage) {
    image = cameraImage;
    notifyListeners();
  }

  Future<bool> pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return false;
      imagePath = image.path;
      imageFile = File(imagePath);
      imageBytes = await imageFile.readAsBytes();
      base64String = base64.encode(imageBytes);
      saveGalleryImage(imageFile);
    } on PlatformException catch (e) {
      debugPrint('$e');
    }
    return true;
  }

  Future<bool> pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 50, // <- Reduce Image quality
          maxHeight: 500, // <- reduce the image size
          maxWidth: 500);
      debugPrint(image?.name ?? "No name");
      if (image == null) return false;
      imagePath = image.path;
      imageFile = File(imagePath);
      imageBytes = await imageFile.readAsBytes();
      base64String = base64.encode(imageBytes);
      toSaveImage();
      saveCameraImage(imageFile);
    } on PlatformException catch (e) {
      debugPrint('$e');
    }
    return true;
  }

  Future toSaveImage() async {
    loadingState = LoadingState.loading;
    try {
      final fileName = imageFile.path.split('/').last;
      debugPrint('FileName: $fileName');
      debugPrint('FilePath : $imagePath');
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imagePath,
        ),
      });

      final response =
          await _getProfileService.setProfilePic(formData: formData);
      log(response.toString());
      if (response.statusMessage == "success") {
        model = ProfileModel.fromJson(response.data);
        notifyListeners();
        loadingState = LoadingState.idle;
        return model;
      }
    } on DioException catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
    } catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
    }
  }

  Future<ProfileModel> getProfileDetails() async {
    loadingState = LoadingState.loading;
    try {
      final res = await _getProfileService.getProfileDetails();
      if (res.statusCode == 200) {
        // locator<ToastService>().showSuccessToast(
        //   'Gotten Profile Details',
        // );
        model = ProfileModel.fromJson(res.data);
        notifyListeners();
        log('model: ${res.data}');
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
