import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/theme/env_theme_manager.dart';
import 'package:insta_king/firebase_options.dart';
import 'package:insta_king/presentation/views/authentication/login/login.dart';
import 'package:insta_king/utils/locator.dart';
import 'package:oktoast/oktoast.dart';

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

class InstaKing extends StatelessWidget {
  const InstaKing({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the system's default theme mode
    final brightness = MediaQuery.of(context).platformBrightness;
    return OKToast(
      child: ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) {
          return MaterialApp(
            title: 'Insta King',
            themeMode: ThemeMode.light,
            theme: brightness == Brightness.dark
                ? EnvThemeManager.darkTheme
                : EnvThemeManager.lightTheme,
            debugShowCheckedModeBanner: false,
            home: const Scaffold(
              body: InstaLogin(),
            ),
          );
        },
      ),
    );
  }
}
