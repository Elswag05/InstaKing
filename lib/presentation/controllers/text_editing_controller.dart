import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textControllerProvider =
    Provider<TextEditingController>((ref) => TextEditingController());

final textValueProvider = ChangeNotifierProvider<TextValueNotifier>((ref) {
  final controller = ref.watch(textControllerProvider);
  final airtimeController = ref.watch(textControllerProvider);
  return TextValueNotifier();
});

class TextValueNotifier extends ChangeNotifier {
  String _textValue = '';
  String _airtimeTextValue = '';

  String get textValue => _textValue;
  String get airtimeTextValue => _airtimeTextValue;

  set textValue(String value) {
    _textValue = value;
    _airtimeTextValue = value;
    notifyListeners();
  }
}
