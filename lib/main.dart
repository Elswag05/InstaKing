import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/theme/env_theme_manager.dart';
import 'package:insta_king/data/services/firebase_api.dart';
import 'package:insta_king/presentation/controllers/insta_dashboard_controller.dart';
import 'package:insta_king/presentation/controllers/insta_login_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'package:oktoast/oktoast.dart';
import 'package:insta_king/firebase_options.dart';
import 'package:insta_king/presentation/views/authentication/login/login.dart';
import 'package:insta_king/utils/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]).then(
    (_) => runApp(
      const ProviderScope(
        child: InstaKingGuide(),
      ),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class InstaKingGuide extends ConsumerStatefulWidget {
  const InstaKingGuide({super.key});
  @override
  ConsumerState<InstaKingGuide> createState() => _InstaKing();
}

class _InstaKing extends ConsumerState<InstaKingGuide> {
  late final DashBoardController screenController =
      ref.read(dashBoardControllerProvider.notifier);

  late Future<String> getEmailFuture;
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
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: SafeArea(
                child: FutureBuilder<String?>(
                  future: getEmailFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      String? email = snapshot.data;

                      if (email == null || email.isEmpty || !weRememberPass) {
                        return const InstaLogin();
                      } else if (email.isNotEmpty) {
                        return const InstaLogin();
                      }
                    }
                    return const TransparentLoadingScreen();
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
