import 'dart:async';
import 'dart:developer';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/data/services/insta_transactions_services.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/insta_transactions_model.dart';

final instaTransactionController =
    ChangeNotifierProvider<TransactionsController>(
        (ref) => TransactionsController());

class TransactionsController extends BaseChangeNotifier {
  InstaTransactionsModel instaTransactionsModel = InstaTransactionsModel();
  TransactionsService transactionsService = TransactionsService();

  Future<InstaTransactionsModel> getTransactions() async {
    loadingState = LoadingState.loading;
    try {
      final response = await transactionsService.getTransacations();
      if (response.statusCode == 200) {
        log('Error Note: Transations Has Been Fetched');
        log('INFO: We have transactions --> ${response.data}');
        try {
          debugPrint('Starting out the map!');
          //debugPrint('${response.data.runtimeType}');
          //final jsonObject = json.decode(response.data);
          //debugPrint('Starting out the map! 001');
          instaTransactionsModel =
              InstaTransactionsModel.fromJson(response.data);
          debugPrint('Starting out the map! 002');
          debugPrint('${instaTransactionsModel.data}');
        } catch (e) {
          log(' Error 101: $e');
        }
        notifyListeners();
        loadingState = LoadingState.idle;
        return instaTransactionsModel;
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
    return instaTransactionsModel;
  }
}
