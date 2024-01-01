import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_king/presentation/controllers/insta_dashboard_controller.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/base_auth_view.dart';
import 'package:insta_king/presentation/views/authentication/login/login.dart';
import 'package:insta_king/presentation/views/dashboard/insta_dashboard.dart';
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
  late final LocalAuthentication auth;
  late final AnimationController _controller;
  DashBoardController dash = DashBoardController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    auth = LocalAuthentication();
    dash = ref.read(dashBoardControllerProvider.notifier);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                  pageName: ' Sign In',
                  pageCTA: 'Login with fingerprint',
                  isLogin: true,
                  isForgotPassword: true,
                  inversePageName: ' Use details instead',
                  isLoginWithFingerPrint: true,
                  toSignOrLogin: () {
                    _authenticate().then((value) {
                      if (value) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const InstaDashboard(),
                        ));
                      }
                      debugPrint('INFO: To login with fingerprint');
                    });
                  },
                  anyWidget1: Lottie.asset(
                    "assets/animation/fingerprint.json",
                    controller: _controller,
                    onLoaded: (composition) {
                      _controller
                        ..duration = composition.duration
                        ..repeat();
                    },
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _authenticate() async {
    late bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Authenticate to log in',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      debugPrint('User is authenticated ==> $authenticated');
    } on PlatformException catch (e) {
      debugPrint('$e');
    }
    return authenticated;
  }
}
