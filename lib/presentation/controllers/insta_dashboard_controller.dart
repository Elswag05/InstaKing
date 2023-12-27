import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/utils/locator.dart';

final dashBoardControllerProvider = ChangeNotifierProvider<DashBoardController>(
  (ref) => DashBoardController(),
);

final SecureStorageService secureStorageService =
    SecureStorageService(secureStorage: const FlutterSecureStorage());

class DashBoardController extends BaseChangeNotifier {
  int page = 0;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  String _userEmail = "";
  String get userEmail => _userEmail;
  bool _deviceHasInternet = true;
  bool get checkDeviceInternet => _deviceHasInternet;

  // set isLoggedIn(bool value) {
  //   isLoggedIn = value;
  //   notifyListeners();
  // }

  Future<String> getName() async {
    String? name = await secureStorageService.read(key: "name");
    List<String> part = name.toString().split(" ");
    name = part[0];
    return name;
  }

  Future<String> getImage() async {
    String? picture = await secureStorageService.read(key: "picture");
    return picture as String;
  }

  Future<String> getEmail() async {
    String? email = await secureStorageService.read(key: "email");

    if (email == null) {
      _isLoggedIn = false;
      return '';
    } else if (email.isEmpty) {
      return '';
    } else {
      try {
        await locator<SecureStorageService>().write(
          key: 'loginMail',
          value: email,
        );
        _userEmail = await secureStorageService.read(key: 'loginMail') ?? '';
      } catch (e) {
        debugPrint('$e');
      }
      _isLoggedIn = true;
      _userEmail = email;
      return email;
    }
  }

  // Future<bool> checkInternetConnection() async {
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi) {
  //     debugPrint('Connectivity is true');
  //     _deviceHasInternet = true;
  //     return true;
  //   } else {
  //     debugPrint('Connectivity is false');
  //     _deviceHasInternet = false;
  //     return false;
  //   }
  // }

  Future<bool> getKey(String key) async {
    String? stringn = await secureStorageService.read(key: key);
    if (stringn == null) {
      return false;
    } else if (stringn.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> getId() async {
    String? id = await secureStorageService.read(key: "id");
    return id as String;
  }

  void setPage(int num) {
    page = num;
    notifyListeners();
  }

  void setTwoPage() {
    page = 2;
    notifyListeners();
  }

  void switchPage(int index) {
    page = index;
    notifyListeners();
  }
}
