import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/data/services/categories_services.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/insta_get_category_model.dart';
import 'package:insta_king/presentation/model/insta_get_one_service_detail_model.dart';
import 'package:insta_king/presentation/model/insta_get_service_details_model.dart';
import 'package:insta_king/utils/locator.dart';

final instaCategoriesController = ChangeNotifierProvider<CategoriesController>(
    (ref) => CategoriesController());

class CategoriesController extends BaseChangeNotifier {
  final CategoriesService categoriesService = CategoriesService();
  final GetCategoriesService getCategoriesService = GetCategoriesService();
  final GetAllServiceDetails getAllServiceDetails = GetAllServiceDetails();
  final GetOneServiceDetails getOneServiceDetails = GetOneServiceDetails();
  late GetAllServicesModel getAllServicesModel = GetAllServicesModel();
  late GetCategoriesModel getCategoriesModel = GetCategoriesModel();
  late GetOneServiceDetailsModel getOneServiceDetailsModel =
      GetOneServiceDetailsModel();
  late List<DropdownMenuItem<String>> allCategoriesModel = [];
  late List<DropdownMenuItem<String>> allServicesModel = [];
  late List<dynamic>? filteredData = [];
  late List<dynamic>? filteredServiceData = [];
  late String selectedServiceValue = '9486';
  late String newServiceValue = '';
  String get newSelectedValue => selectedServiceValue;
  String get newValue => newServiceValue;
  late String newSelectedServiceValue;

  void setNewValue(newValue) {
    newServiceValue = newValue;
    notifyListeners();
  }

  @override
  LoadingState loadingState = LoadingState.idle;

  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  Future<bool> toGetAllCategories() async {
    loadingState = LoadingState.loading;
    try {
      final res = await categoriesService.getAllCategories();
      getAllServiceDetails.getAllServicesDetails();
      debugPrint('${res.data}');
      if (res.statusCode == 200) {
        final getCategoriesModel = GetCategoriesModel.fromJson(res.data);
        allCategoriesModel = getCategoriesModel.data?.map((category) {
              return DropdownMenuItem<String>(
                value: category.id
                    .toString(), // Set a unique identifier for the category
                child: Text(category.name ?? ""), // Ensure name is not null
              );
            }).toList() ??
            [];
        loadingState = LoadingState.idle;
        locator<ToastService>().showSuccessToast(
          'Categories loaded successfully',
        );
        debugPrint("INFO: Success converting data to model");
        if (getCategoriesModel.status == 'success') {
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

  Future<List<dynamic>?> searchByName(String keyword) async {
    if (getAllServicesModel.data == null) {
      return null;
    }

    // Filter the data list based on the keyword in the name field
    filteredData = getAllServicesModel.data!
        .where((datum) => datum.name!.contains(keyword))
        .toList();
    notifyListeners();
    debugPrint('${filteredData.toString()}');
    return filteredData;
  }

  Future<bool> getSpecificCategories(String categoryId) async {
    loadingState = LoadingState.loading;
    try {
      final res = await getCategoriesService.getSpecificCategoriesServices(
          categoryId: categoryId);
      if (res.statusCode == 200) {
        //final data = GetspecificCategoriesModel.fromJson(res.data);
        loadingState = LoadingState.idle;
        print(res.data);
        //if (data.status == 'success') {
        return true;
        //
        // }
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

  Future<GetAllServicesModel> toGetAllServiceDetail() async {
    loadingState = LoadingState.loading;
    try {
      final res = await getAllServiceDetails.getAllServicesDetails();
      //debugPrint('${res.data}');
      if (res.statusCode == 200) {
        getAllServicesModel = GetAllServicesModel.fromJson(res.data);
        loadingState = LoadingState.idle;
        return getAllServicesModel;
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
    return getAllServicesModel;
  }

  Future<List<DropdownMenuItem<String>>> toGetDropdownItemsById(
    String targetId,
  ) async {
    loadingState = LoadingState.loading;
    try {
      final res = await getAllServiceDetails.getAllServicesDetails();
      if (res.statusCode == 200) {
        getAllServicesModel = GetAllServicesModel.fromJson(res.data);

        // Filter the data based on the specified id
        final filteredServiceData = getAllServicesModel.data
            ?.where((category) => category.categoryId == targetId)
            .toList();

        // Determine the selected service value based on the first id obtained
        newSelectedServiceValue = filteredServiceData?.isNotEmpty == true
            ? filteredServiceData![0].id.toString()
            : "";

        // Convert the filtered data to List<DropdownMenuItem<String>>
        allServicesModel = filteredServiceData
                ?.map((category) => DropdownMenuItem<String>(
                      value: category.id.toString(),
                      child: AutoSizeText(
                        category.name ?? "",
                        minFontSize: 6.sp,
                        stepGranularity: 2.sp,
                        style: TextStyle(
                          fontFamily: 'Montesserat',
                          fontSize: 12.sp,
                        ),
                      ),
                    ))
                .toList() ??
            [];

        // Notify listeners and update the selectedServiceValue
        if (newValue != '') {
          selectedServiceValue = newValue;
          notifyListeners();
        }
        if (targetId.toString() != '703' && newValue == '') {
          selectedServiceValue = newSelectedServiceValue;
          notifyListeners();
        }

        notifyListeners();
        toGetOneServiceDetail(newSelectedServiceValue);
        loadingState = LoadingState.idle;
        return allServicesModel;
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
    return [];
  }

  Future<bool> toGetOneServiceDetail(String serviceId) async {
    loadingState = LoadingState.loading;
    try {
      final res = await getOneServiceDetails.getOneServicesDetails(serviceId);
      if (res.statusCode == 200) {
        getOneServiceDetailsModel =
            GetOneServiceDetailsModel.fromJson(res.data);
        loadingState = LoadingState.idle;
        if (getOneServiceDetailsModel.status == 'success') {
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
}
