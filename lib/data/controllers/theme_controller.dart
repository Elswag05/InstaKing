import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/theme/env_theme_manager.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/data/controllers/base_controller.dart';

final themeControllerProvider = ChangeNotifierProvider<ThemeController>(
  (ref) => ThemeController(),
);

final SecureStorageService secureStorageService =
    SecureStorageService(secureStorage: const FlutterSecureStorage());

class ThemeController extends BaseChangeNotifier {
  ThemeData currentTheme = EnvThemeManager.lightTheme;
  bool get isDarkTheme => currentTheme.brightness == Brightness.dark;
  set isDarkTheme(bool isDarkTheme) {
    currentTheme =
        isDarkTheme ? EnvThemeManager.darkTheme : EnvThemeManager.lightTheme;
    notifyListeners();
  }

  void toggleTheme() {
    currentTheme =
        isDarkTheme ? EnvThemeManager.lightTheme : EnvThemeManager.darkTheme;
    //log('Your current theme is ${currentTheme.toString()}');
    debugPrint('Theme changed, value is now: ${isDarkTheme.toString()}');
    notifyListeners();
  }

  // void setDeviceTheme(Brightness deviceBrightness) {
  //   if (deviceBrightness == Brightness.light) {
  //     currentTheme = EnvThemeManager.lightTheme;
  //   } else if (deviceBrightness == Brightness.dark) {
  //     currentTheme = EnvThemeManager.darkTheme;
  //   }
  // }
}
