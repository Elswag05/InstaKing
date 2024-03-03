// import 'dart:async';
// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:insta_king/data/services/deposit_service.dart';
// import 'package:insta_king/data/services/error_service.dart';
// import 'package:insta_king/presentation/controllers/base_controller.dart';
// import 'package:insta_king/presentation/model/insta_deposit_model.dart';

// final instaDepositController =
//     ChangeNotifierProvider<DepositsController>((ref) => DepositsController());

// class DepositsController extends BaseChangeNotifier {
//   InstaDepositModel instaDepositsModel = InstaDepositModel();
//   DepositService depositsService = DepositService();
//   bool isThereNextPage = false;
//   bool isTherePreviousPage = false;
//   int instaCurrentPage = 1;
//   int instaNextPage = 0;
//   int instaLastPage = 0;
//   int instaValue = 1;
//   bool loadStraight = false;

//   void disposeTrx() {
//     instaDepositsModel.data = null;
//     instaDepositsModel.data = [];
//     super.dispose();
//   }

//   getNextScreen() {
//     instaLastPage = instaDepositsModel.lastPage ?? 0;
//     instaCurrentPage = instaDepositsModel.currentPage!;
//     instaNextPage = getLastNumber(instaDepositsModel.nextPage);
//     instaValue = instaNextPage;
//     debugPrint('CurrentPage ==> $instaCurrentPage');
//     if (instaCurrentPage < instaLastPage &&
//         instaLastPage != 0 &&
//         instaCurrentPage != instaLastPage) {
//       loadStraight = true;
//       getDeposits(instaValue);
//     }
//   }

//   getPreviousScreen() {
//     instaLastPage = instaDepositsModel.lastPage ?? 0;
//     instaCurrentPage = instaDepositsModel.currentPage!;
//     instaNextPage = getLastNumber(
//       instaDepositsModel.nextPage,
//     );
//     instaValue = instaLastPage;
//     debugPrint('CurrentPage ==> $instaCurrentPage');
//     if (instaCurrentPage > 1 &&
//         instaCurrentPage < instaLastPage &&
//         instaCurrentPage == instaNextPage - 1) {
//       loadStraight = true;
//       getDeposits(instaValue);
//     }
//   }

//   int getLastNumber(String input) {
//     RegExp regex = RegExp(r'\d+$');
//     Match? match = regex.firstMatch(input);

//     if (match != null) {
//       String numberString = match.group(0)!;
//       return int.parse(numberString);
//     }

//     // Return a default value or handle the case where no number is found
//     return 1;
//   }

//   Future<InstaDepositModel> getDeposits(int valueHere) async {
//     if (instaDepositsModel.data == null ||
//         instaDepositsModel.data == [] ||
//         loadStraight) {
//       try {
//         //loadingState = LoadingState.loading;
//         final response = await depositsService.getDeposits(valueHere);

//         if (response.statusCode == 200) {
//           log('Error Note: Deposits Has Been Fetched');
//           //log('INFO: We have Deposits --> ${response.data}');
//           try {
//             debugPrint('Starting out the map!');
//             instaDepositsModel = InstaDepositModel.fromJson(response.data);
//             debugPrint('the map! has been gotten!');
//             instaLastPage = instaDepositsModel.lastPage ?? 0;
//             instaCurrentPage = instaDepositsModel.currentPage!;
//             instaNextPage = getLastNumber(instaDepositsModel.nextPage);
//             if (instaCurrentPage != 1 || instaLastPage != 0) {
//               isTherePreviousPage = true;
//               notifyListeners();
//             }
//             if (instaCurrentPage != instaLastPage || instaLastPage != 0) {
//               isThereNextPage = true;
//               notifyListeners();
//             }
//             loadStraight = false;
//           } catch (e) {
//             log(' Error 101: $e');
//           }
//           // loadingState = LoadingState.idle;
//           return instaDepositsModel;
//         } else {
//           throw Error();
//         }
//       } on DioException catch (e) {
//         //loadingState = LoadingState.error;
//         ErrorService.handleErrors(e);
//       } catch (e) {
//         //loadingState = LoadingState.error;
//         ErrorService.handleErrors(e);
//       }
//     } else {
//       return instaDepositsModel;
//     }
//     return instaDepositsModel;
//   }
// }
