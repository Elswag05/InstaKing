import 'package:flutter/material.dart';
import 'package:insta_king/core/constants/enum.dart';

class BaseChangeNotifier extends ChangeNotifier {
  BaseChangeNotifier();

  LoadingState _loadingState = LoadingState.idle;
  LoadingState get loadingState => _loadingState;
  set loadingState(LoadingState state) {
    _loadingState = state;
    notifyListeners();
  }

  // Other methods and properties can remain as needed for your application.
}
