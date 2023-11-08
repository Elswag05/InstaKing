import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';

final orderControllerProvider = ChangeNotifierProvider<OrderController>(
  (ref) => OrderController(),
);

final SecureStorageService secureStorageService =
    SecureStorageService(secureStorage: const FlutterSecureStorage());

class OrderController extends BaseChangeNotifier {
  int view = 0;
  int get currentView => view;

  void switchPage(int index) {
    view = index;
    notifyListeners();
  }
}
