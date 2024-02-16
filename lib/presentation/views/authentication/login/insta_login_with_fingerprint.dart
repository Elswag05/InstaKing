import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/presentation/controllers/insta_dashboard_controller.dart';
import 'package:insta_king/presentation/controllers/insta_login_controller.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/base_auth_view.dart';
import 'package:insta_king/presentation/views/authentication/login/login.dart';
import 'package:insta_king/presentation/views/dashboard/insta_dashboard.dart';
import 'package:insta_king/presentation/views/splash_screen/insta_splash.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

class InstaLoginWithFingerprint extends ConsumerStatefulWidget {
  const InstaLoginWithFingerprint({super.key});

  @override
  ConsumerState<InstaLoginWithFingerprint> createState() =>
      _InstaLoginWithFingerprintState();
}

class _InstaLoginWithFingerprintState
    extends ConsumerState<InstaLoginWithFingerprint>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  DashBoardController dash = DashBoardController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    dash = ref.read(dashBoardControllerProvider.notifier);
    checkBiometricsAndNavigate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkBiometricsAndNavigate() async {
    await dash.getEmail();
    bool canCheckBiometrics = ref.read(instaLoginController).canCheckBiometrics;
    List<BiometricType> availableBiometrics =
        ref.read(instaLoginController).availableBiometrics;
    if (canCheckBiometrics && availableBiometrics.isEmpty) {
      // Navigate to the next screen if conditions are met
      try {
        setState(() {
          Navigator.pushReplacement(
            context,
            PageTransition(
              const InstaDashboard(),
            ),
          );
        });
      } catch (e) {
        debugPrint('$e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Stack(
          children: [
            FutureBuilder(
              future: dash.getEmail(),
              builder: ((context, snapshot) {
                return BaseAuthView(
                  toGoToInversePage: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const InstaLogin(),
                      ),
                    );
                  },
                  checkBoxText: '',
                  callToActionFooterText: 'Alternative?',
                  callToActionText: '',
                  pageName:
                      'Welcome back ${ref.read(instaProfileController).model.user?.username ?? ""}',
                  pageCTA: 'Login with fingerprint',
                  isLogin: true,
                  isForgotPassword: false,
                  inversePageName: ' Use details instead',
                  isLoginWithFingerPrint: true,
                  toPerformAuthAction: () {
                    ref
                        .read(instaLoginController)
                        .toAuthenticate()
                        .then((value) {
                      if (value) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const InstaDashboard(),
                        ));
                      }
                      debugPrint('INFO: To login with fingerprint');
                    });
                  },
                  anyWidget1: Container(
                    padding: EdgeInsets.only(
                      top: 60.h,
                      bottom: 30.h,
                    ),
                    child: Lottie.asset(
                      "assets/animation/fingerprint.json",
                      width: 300.w,
                      controller: _controller,
                      onLoaded: (composition) {
                        _controller
                          ..duration = composition.duration
                          ..repeat();
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
