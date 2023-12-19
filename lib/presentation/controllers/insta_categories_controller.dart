import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/services/categories_services.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/insta_get_category_model.dart';
import 'package:insta_king/presentation/model/insta_get_one_service_detail_model.dart';
import 'package:insta_king/presentation/model/insta_get_service_details_model.dart';

final instaCategoriesProvider =
    Provider<CategoriesController>((ref) => CategoriesController());

final instaCatValueProvider =
    ChangeNotifierProvider<CategoriesController>((ref) {
  final controller = ref.watch(instaCategoriesProvider);
  return CategoriesController();
});

class CategoryItem {
  final String id;
  final String name;

  CategoryItem({required this.id, required this.name});
}

class ServiceItem {
  final String id;
  final String name;

  ServiceItem({required this.id, required this.name});
}

class CategoriesController extends BaseChangeNotifier {
  final CategoriesService categoriesService = CategoriesService();
  final GetCategoriesService getCategoriesService = GetCategoriesService();
  final GetAllServiceDetails getAllServiceDetails = GetAllServiceDetails();
  final GetOneServiceDetails getOneServiceDetails = GetOneServiceDetails();
  late GetAllServicesModel getAllServicesModel = GetAllServicesModel();
  late GetCategoriesModel getCategoriesModel = GetCategoriesModel();
  late GetOneServiceDetailsModel getOneServiceDetailsModel =
      GetOneServiceDetailsModel();
  List<CategoryItem> allCategoriesModel = <CategoryItem>[];
  List<ServiceItem> allServicesModel = [];
  late List<dynamic>? filteredData = [];
  late List<dynamic>? filteredServiceData = [];
  late String _selectedServiceValue = '9486';
  late String _selectedServiceName;
  late String _selectedCategoryValue = '703';
  late String _selectedCategoryName;
  String get selectedService => _selectedServiceValue;
  String get selectedServiceName => _selectedServiceName;
  String get selectedCategory => _selectedCategoryValue;
  String get selectedCategoryName => _selectedCategoryName;
  bool _isCatSet = false;
  bool _isServiceSet = false;
  bool get isCatSet => _isCatSet;
  bool get isServiceSet => _isServiceSet;

  void setCatValue(String newValue, String name) {
    _selectedCategoryValue = newValue;
    _selectedCategoryName = name;
    _isCatSet = true;
    notifyListeners();
  }

  void setServiceValue(String newValue, String name) {
    _selectedServiceValue = newValue;
    _selectedServiceName = name;
    _isServiceSet = true;
    notifyListeners();
  }

  String calculatePricePerUnit(String intakePriceStr, String quantityStr) {
    // Convert string inputs to numeric values
    double intakePrice = double.tryParse(intakePriceStr) ?? 0.0;
    int quantity = int.tryParse(quantityStr) ?? 0;

    // Calculate the price per unit
    double pricePerUnit = (intakePrice / 1000) * quantity;
    notifyListeners();
    // Return the result as a string
    return pricePerUnit.toString();
  }

  @override
  LoadingState loadingState = LoadingState.idle;

  // Future setServiceValue(String newValu) {
  //   return toGetDropdownItemsById(newValu);
  // }

  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  Future<bool> toGetAllCategories() async {
    loadingState = LoadingState.loading;
    try {
      final res = await categoriesService.getAllCategories();
      getAllServiceDetails.getAllServicesDetails();
      toGetDropdownItemsById(_selectedCategoryValue);
      //debugPrint('${res.data}');
      if (res.statusCode == 200) {
        final getCategoriesModel =
            GetCategoriesModel.fromJson(res.data as Map<String, dynamic>);
        allCategoriesModel = getCategoriesModel.data?.map((category) {
              return CategoryItem(
                id: category.id.toString(),
                name: category.name ?? "",
              );
            }).toList() ??
            <CategoryItem>[];

        loadingState = LoadingState.idle;
        // locator<ToastService>().showSuccessToast(
        //   'Categories loaded successfully',
        // );
        debugPrint("INFO: Success converting data to model");
        if (getCategoriesModel.status == 'success') {
          return true;
        }
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

  Future<List<dynamic>?> searchByName(String keyword) async {
    if (getAllServicesModel.data == null) {
      return null;
    }

    // Filter the data list based on the keyword in the name field
    filteredData = getAllServicesModel.data!
        .where((datum) => datum.name!.contains(keyword))
        .toList();
    notifyListeners();
    debugPrint(filteredData.toString());
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
        debugPrint('${res.data}');
        //if (data.status == 'success') {
        return true;
        //
        // }
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
        // throw Error();
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

  Future<List<ServiceItem>> toGetDropdownItemsById(
    String targetId,
  ) async {
    if (allServicesModel.isNotEmpty) {
      // Filter the data based on the specified id
      final filteredServiceData = getAllServicesModel.data
          ?.where((category) => category.categoryId == targetId)
          .toList();

      // Determine the selected service value based on the first id obtained
      _selectedServiceValue = filteredServiceData?.isNotEmpty == true
          ? filteredServiceData![0].id.toString()
          : "";

      // Convert the filtered data to List<DropdownMenuItem<String>>
      allServicesModel = filteredServiceData
              ?.map((category) => ServiceItem(
                    id: category.id.toString(),
                    name: category.name ?? "",
                  ))
              .toList() ??
          [];
      loadingState = LoadingState.idle;
      toGetOneServiceDetail(_selectedServiceValue);
      return allServicesModel;
    }
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
        _selectedServiceValue = filteredServiceData?.isNotEmpty == true
            ? filteredServiceData![0].id.toString()
            : "";

        // Convert the filtered data to List<DropdownMenuItem<String>>
        allServicesModel = filteredServiceData
                ?.map((category) => ServiceItem(
                      id: category.id.toString(),
                      name: category.name ?? "",
                    ))
                .toList() ??
            [];

        // Notify listeners and update the selectedServiceValue
        // if (newValue != '') {
        //   selectedServiceValue = newValue;
        //   notifyListeners();
        // }
        // if (targetId.toString() != '703' && newValue == '') {
        //   selectedServiceValue = newSelectedServiceValue;
        //   notifyListeners();
        // }

        // notifyListeners();

        loadingState = LoadingState.idle;
        return allServicesModel;
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
    return [];
  }

  String? getOneServiceName(String? serviceId) {
    if (serviceId != null || serviceId != '') {
      toGetOneServiceDetail(serviceId!);
    }
    return getOneServiceDetailsModel.data?.name;
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
