import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/theme/env_theme_manager.dart';
import 'package:insta_king/presentation/controllers/insta_dashboard_controller.dart';
import 'package:insta_king/presentation/controllers/theme_controller.dart';
import 'package:insta_king/presentation/views/dashboard/insta_dashboard.dart';
import 'package:oktoast/oktoast.dart';

import 'package:insta_king/firebase_options.dart';
import 'package:insta_king/presentation/views/authentication/login/login.dart';
import 'package:insta_king/utils/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]).then(
    (_) => runApp(
      const ProviderScope(
        child: InstaKing(),
      ),
    ),
  );
}

class InstaKing extends ConsumerWidget {
  const InstaKing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget initialScreen = const InstaLogin();
    final screenController = ref.read(dashBoardControllerProvider.notifier);
    final themeController = ref.watch(themeControllerProvider.notifier);

    bool setTheme() {
      return MediaQuery.of(context).platformBrightness == Brightness.dark
          ? true
          : false;
    }

    void getEmail() async {
      String emailDey = await screenController.getEmail();
      emailDey == '' || emailDey == 'null' || emailDey.isEmpty
          ? debugPrint('Info: Email not found')
          : debugPrint('${emailDey}is your email');

      if (emailDey.isNotEmpty && emailDey != 'null') {
        initialScreen = const InstaDashboard();
      }
    }

    themeController.setDeviceTheme(MediaQuery.of(context).platformBrightness);
    getEmail();

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
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: initialScreen,
            ),
          );
        },
      ),
    );
  }
}
