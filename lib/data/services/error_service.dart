import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/utils/locator.dart';

final ErrorService errorService = locator<ErrorService>();

class ErrorService {
  String timeoutMessage = 'Timeout. Please, try again.';
  String defaultErrorMessage = 'Something went wrong! please try again later';

  static void handleErrors(dynamic e) {
    String message = '';
    if (e is String) {
      // Handle string error messages
      message = e;
    } else if (e is Map) {
      // Handle map error messages
      if (e['errors'] != null) {
        message = e['errors'][0]['message'];
      } else if (e['message'] != null) {
        message = e['message'];
      } else {
        message = errorService.defaultErrorMessage;
        debugPrint('${e.toString()} Things 000');
      }
    } else if (e is TimeoutException) {
      // Handle timeout errors
      message = errorService.timeoutMessage;
    } else if (e is Error) {
      // Handle general errors
      message = errorService.defaultErrorMessage;
      debugPrint('${e.runtimeType} Things 001');
      debugPrint('${e.toString()} Things 001');
    } else if (e is Exception) {
      // Handle general exceptions
      message = errorService.defaultErrorMessage;
      debugPrint('${e.toString()} Things 002');
    } else if (e is FormatException) {
      // Handle formatting errors
      message = 'There is something wrong with the format.';
    } else if (e is JsonUnsupportedObjectError) {
      // Handle JSON parsing errors
      message = 'There is something wrong with the JSON format.';
    } else {
      // Handle other types of errors
      message = errorService.defaultErrorMessage;
      debugPrint('${e.toString()} Things 004');
    }
    debugPrint('ERROR MESSAGE :: $message Things 004');
    // Show error message using a toast widget
    // locator<ToastService>().showErrorToast(
    //   message,
    // );
  }
}
