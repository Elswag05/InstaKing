// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textControllerProvider =
    Provider<TextEditingController>((ref) => TextEditingController());

final textValueProvider = ChangeNotifierProvider<TextValueNotifier>((ref) {
  final controller = ref.watch(textControllerProvider);
  final dataTextController = ref.watch(textControllerProvider);
  final networkTextController = ref.watch(textControllerProvider);
  final airtimeTextController = ref.watch(textControllerProvider);
  return TextValueNotifier();
});

class TextValueNotifier extends ChangeNotifier {
  String _textValue = '';
  String _airtimeTextValue = '';
  String _dataTextValue = '';
  String _networkTextValue = '';

  String get textValue => _textValue;
  String get airtimeTextValue => _airtimeTextValue;
  String get dataTextValue => _dataTextValue;
  String get networkTextValue => _networkTextValue;

  set textValue(String value) {
    _textValue = value;
    notifyListeners();
  }

  set airtimeTextValue(String value) {
    _airtimeTextValue = value;
    notifyListeners();
  }

  set networkTextValue(String value) {
    _networkTextValue = value;
    notifyListeners();
  }

  set dataTextValue(value) {
    _dataTextValue = value;
    notifyListeners();
  }
}
