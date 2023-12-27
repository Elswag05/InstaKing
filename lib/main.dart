import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/theme/env_theme_manager.dart';
import 'package:insta_king/data/services/notification.dart';
import 'package:insta_king/no_internet.dart';
import 'package:insta_king/presentation/controllers/insta_dashboard_controller.dart';
import 'package:insta_king/presentation/controllers/insta_login_controller.dart';
import 'package:insta_king/presentation/controllers/insta_network_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'package:oktoast/oktoast.dart';
import 'package:insta_king/presentation/views/authentication/login/login.dart';
import 'package:insta_king/utils/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  await LocalNotification.initLocalNotifications();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseApi().initNotifications();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]).then(
    (_) => runApp(
      const ProviderScope(
        child: InstaKingGuide(),
      ),
    ),
  );
}

// background handler
Future backgroundHandler(RemoteMessage msg) async {}

final navigatorKey = GlobalKey<NavigatorState>();

class InstaKingGuide extends ConsumerStatefulWidget {
  const InstaKingGuide({super.key});
  @override
  ConsumerState<InstaKingGuide> createState() => _InstaKing();
}

class _InstaKing extends ConsumerState<InstaKingGuide> {
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  late bool yourBool = false;

  late final DashBoardController screenController =
      ref.read(dashBoardControllerProvider);

  late Future<String> getEmailFuture;
  late final weRememberPass =
      ref.read(instaLoginController.notifier).isBoxChecked;
  late bool isConnected;
  @override
  void initState() {
    getEmailFuture = screenController.getEmail();
    networkConnectivity.initialise();
    networkConnectivity.myStream.listen((source) {
      _source = source;
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          yourBool = _source.values.toList()[0] ? true : false;
          break;
        case ConnectivityResult.wifi:
          yourBool = _source.values.toList()[0] ? true : false;
          break;
        case ConnectivityResult.none:
        default:
          yourBool = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    networkConnectivity.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) {
          return MaterialApp(
            title: 'Insta King',
            themeMode: ThemeMode.system,
            theme: EnvThemeManager.lightTheme,
            darkTheme: EnvThemeManager.darkTheme,
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: SafeArea(
                  child: Stack(
                children: [
                  FutureBuilder<String?>(
                    future: getEmailFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        String? email = snapshot.data;

                        if (email == null || email.isEmpty || !weRememberPass) {
                          return const InstaLogin();
                        } else {
                          return const InstaLogin();
                        }
                      }
                      return const TransparentLoadingScreen();
                    },
                  ),
                  if (!yourBool) const NoInternet(),
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}
