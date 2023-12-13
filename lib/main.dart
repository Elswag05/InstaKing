import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/theme/env_theme_manager.dart';
import 'package:insta_king/presentation/controllers/insta_dashboard_controller.dart';
import 'package:insta_king/presentation/controllers/insta_login_controller.dart';
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
        child: InstaKingGuide(),
      ),
    ),
  );
}

class InstaKingGuide extends ConsumerStatefulWidget {
  const InstaKingGuide({super.key});
  @override
  ConsumerState<InstaKingGuide> createState() => _InstaKing();
}

class _InstaKing extends ConsumerState<InstaKingGuide> {
  late final DashBoardController screenController =
      ref.read(dashBoardControllerProvider.notifier);
  late final ThemeController themeController =
      ref.watch(themeControllerProvider.notifier);
  late Future<String> getEmailFuture;
  late final isLoggedIn =
      ref.read(instaLoginController.notifier).isUserLoggedIn;
  late final weRememberPass =
      ref.read(instaLoginController.notifier).isBoxChecked;

  @override
  void initState() {
    getEmailFuture = screenController.getEmail();
    super.initState();
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
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: SafeArea(
                child: FutureBuilder<String?>(
                  future: getEmailFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      String? email = snapshot.data;
                      print('${isLoggedIn.toString()}');
                      if ((email == null || email.isEmpty || !isLoggedIn) ||
                          (isLoggedIn && !weRememberPass)) {
                        return const InstaLogin();
                      } else if (weRememberPass   ) {
                        return const InstaDashboard();
                      }
                    }
                    // In case none of the conditions are met, return an empty container.
                    return Container();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
