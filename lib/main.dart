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
import 'package:insta_king/presentation/views/authentication/auth_shared/navigation_page.dart';
import 'package:insta_king/presentation/views/authentication/login/insta_login_with_fingerprint.dart';
import 'package:insta_king/presentation/views/onboarding/insta_onboarding.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'package:insta_king/presentation/views/splash_screen/insta_splash.dart';
import 'package:oktoast/oktoast.dart';
import 'package:insta_king/utils/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      ProviderScope(
        child: MaterialApp(
          title: 'InstaKing',
          themeMode: ThemeMode.system,
          theme: EnvThemeManager.lightTheme,
          darkTheme: EnvThemeManager.darkTheme,
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: const InstaSplash(),
        ),
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

  Future<bool> isOnboardingComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('showOnboarding') == false;
  }

  late final DashBoardController screenController =
      ref.read(dashBoardControllerProvider);

  late Future<String> getEmailFuture;
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
    ref.read(instaLoginController).initBiomLoginAuth();
    super.initState();
  }

  @override
  void dispose() {
    networkConnectivity.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ref.read(themeControllerProvider).brightnessOfDevice =
    //     MediaQuery.of(context).platformBrightness;
    return OKToast(
      child: ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) {
          return MaterialApp(
            title: 'InstaKing',
            themeMode: ThemeMode.system,
            // ThemeMode.values[ref.read(themeControllerProvider).themeValue],
            theme: EnvThemeManager.lightTheme,
            darkTheme: EnvThemeManager.darkTheme,
            //   navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    FutureBuilder<String?>(
                      future: getEmailFuture,
                      builder: (context, snapshot) {
                        String? email = snapshot.data;
                        return FutureBuilder<bool>(
                          future: isOnboardingComplete(),
                          builder: (context, onboardingSnapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                onboardingSnapshot.connectionState ==
                                    ConnectionState.done) {
                              bool onboardingComplete =
                                  onboardingSnapshot.data ?? false;
                              if (!onboardingComplete) {
                                debugPrint('Onboarding screen is active');
                                return const InstaOnboarding(); // Show onboarding screen
                              } else if (email == null || email.isEmpty) {
                                return const InstaAuthNavigator();
                              } else if (email.isNotEmpty) {
                                ref.read(instaLoginController).toCheckBox(true);
                                return const InstaLoginWithFingerprint();
                              }
                            }
                            return const TransparentLoadingScreen();
                          },
                        );
                      },
                    ),
                    if (!yourBool) const NoInternet(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
