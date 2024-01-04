import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/data/services/insta_transactions_services.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/insta_transactions_model.dart';

final instaTransactionController =
    ChangeNotifierProvider<TransactionsController>(
        (ref) => TransactionsController());

class DepositItem {
  final String number;
  final String type;
  final String service;
  final String trxCode;
  final String date;
  final String amount;
  final String status;
  final String message;

  DepositItem({
    required this.number,
    required this.type,
    required this.service,
    required this.trxCode,
    required this.date,
    required this.amount,
    required this.status,
    required this.message,
  });
}

class TransactionsController extends BaseChangeNotifier {
  InstaTransactionsModel instaTransactionsModel = InstaTransactionsModel();
  TransactionsService transactionsService = TransactionsService();
  late List<dynamic>? depositData = [];
  late List<DepositItem> depositModel = [];
  bool isThereNextPage = false;
  bool isTherePreviousPage = false;
  int instaCurrentPage = 1;
  int instaNextPage = 0;
  int instaLastPage = 0;
  int instaValue = 1;
  bool loadStraight = false;

  void disposeTrx() {
    instaTransactionsModel.data = null;
    instaTransactionsModel.data = [];
    depositData = [];
    depositModel = [];
    super.dispose();
  }

  getNextScreen() {
    instaLastPage = instaTransactionsModel.lastPage ?? 0;
    instaCurrentPage = instaTransactionsModel.currentPage!;
    instaNextPage = getLastNumber(instaTransactionsModel.nextPage);
    instaValue = instaNextPage;
    debugPrint('CurrentPage ==> $instaCurrentPage');
    if (instaCurrentPage < instaLastPage &&
        instaLastPage != 0 &&
        instaCurrentPage != instaLastPage) {
      loadStraight = true;
      getTransactions(instaValue);
    }
  }

  getPreviousScreen() {
    instaLastPage = instaTransactionsModel.lastPage ?? 0;
    instaCurrentPage = instaTransactionsModel.currentPage!;
    instaNextPage = getLastNumber(
      instaTransactionsModel.nextPage,
    );
    instaValue = instaLastPage;
    debugPrint('CurrentPage ==> $instaCurrentPage');
    if (instaCurrentPage > 1 &&
        instaCurrentPage < instaLastPage &&
        instaCurrentPage == instaNextPage - 1) {
      loadStraight = true;
      getTransactions(instaValue);
    }
  }

  int getLastNumber(String input) {
    RegExp regex = RegExp(r'\d+$');
    Match? match = regex.firstMatch(input);

    if (match != null) {
      String numberString = match.group(0)!;
      return int.parse(numberString);
    }

    // Return a default value or handle the case where no number is found
    return 1;
  }

  Future<InstaTransactionsModel> getTransactions(int valueHere) async {
    if (instaTransactionsModel.data == null ||
        instaTransactionsModel.data == [] ||
        loadStraight) {
      try {
        //loadingState = LoadingState.loading;
        final response = await transactionsService.getTransacations(valueHere);

        if (response.statusCode == 200) {
          log('Error Note: Transations Has Been Fetched');
          //log('INFO: We have transactions --> ${response.data}');
          try {
            debugPrint('Starting out the map!');
            instaTransactionsModel =
                InstaTransactionsModel.fromJson(response.data);
            debugPrint('the map! has been gotten!');
            instaLastPage = instaTransactionsModel.lastPage ?? 0;
            instaCurrentPage = instaTransactionsModel.currentPage!;
            instaNextPage = getLastNumber(instaTransactionsModel.nextPage);
            if (instaCurrentPage != 1 || instaLastPage != 0) {
              isTherePreviousPage = true;
              notifyListeners();
            }
            if (instaCurrentPage != instaLastPage || instaLastPage != 0) {
              isThereNextPage = true;
              notifyListeners();
            }
            loadStraight = false;
          } catch (e) {
            log(' Error 101: $e');
          }
          // loadingState = LoadingState.idle;
          return instaTransactionsModel;
        } else {
          throw Error();
        }
      } on DioException catch (e) {
        //loadingState = LoadingState.error;
        ErrorService.handleErrors(e);
      } catch (e) {
        //loadingState = LoadingState.error;
        ErrorService.handleErrors(e);
      }
    } else {
      return instaTransactionsModel;
    }
    return instaTransactionsModel;
  }

  Future<List<dynamic>?> getDeposits() async {
    debugPrint('Starting out the work here');
    if (instaTransactionsModel.data == null ||
        instaTransactionsModel.data == []) {
      log('data is empty');
    }
    debugPrint('${instaTransactionsModel.data?[0].service}');
    depositData = instaTransactionsModel.data!
        .where((datum) => datum.service?.contains('deposit') == true)
        .toList();
    debugPrint("Deposited Data ==> $depositData");
    try {
      final resData = depositData ?? instaTransactionsModel.data;
      depositModel = resData!
          .map((deposit) => DepositItem(
                number: deposit.id.toString(),
                type: deposit.message,
                service: deposit.service,
                trxCode: deposit.code.toString(),
                date: deposit.createdAt.toString(),
                amount: deposit.amount.toString(),
                status: deposit.status,
                message: deposit.message,
              ))
          .toList();
    } catch (e) {
      debugPrint("Geot errior => $e");
    }
    return depositModel;
  }
}
