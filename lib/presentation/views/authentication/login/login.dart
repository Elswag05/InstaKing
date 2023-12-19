import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/core/utils/my_strings.dart';
import 'package:insta_king/presentation/controllers/insta_dashboard_controller.dart';
import 'package:insta_king/presentation/controllers/insta_login_controller.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/base_auth_view.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/text_form.dart';
import 'package:insta_king/presentation/views/authentication/login/forgot_password.dart';
import 'package:insta_king/presentation/views/authentication/signup/sign_up.dart';
import 'package:insta_king/presentation/views/dashboard/insta_dashboard.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

class InstaLogin extends StatefulWidget {
  const InstaLogin({super.key});

  @override
  State<InstaLogin> createState() => _InstaLoginState();
}

class _InstaLoginState extends State<InstaLogin> with TickerProviderStateMixin {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late final LocalAuthentication auth;
  bool supportState = false;
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          supportState = isSupported;
        }));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        Future getEmail =
            ref.read(dashBoardControllerProvider.notifier).getEmail();
        getEmail;
        final bool userloggedIn = false;
        //     ref.read(dashBoardControllerProvider.notifier).isLoggedIn;
        // final bool userloggedIn =
        //     ref.read(dashBoardControllerProvider.notifier).isLoggedIn;
        final instaLoginState = ref.watch(instaLoginController);
        final LoadingState loadingState = instaLoginState.loadingState;

        return Stack(
          children: [
            FutureBuilder(
              future: getEmail,
              builder: ((context, snapshot) {
                return BaseAuthView(
                  pageName: ' Sign In',
                  pageCTA: userloggedIn ? 'Login with fingerprint' : 'Log in',
                  isLogin: true,
                  callToActionText: userloggedIn ? "" : 'Forgot Password',
                  callToActionFooterText:
                      userloggedIn ? "" : "Don't have an account yet?",
                  checkBoxText: userloggedIn ? "" : "Remember me",
                  inversePageName: userloggedIn ? "" : ' Sign Up',
                  checked: ref.watch(instaLoginController).isBoxChecked,
                  isForgotPassword: userloggedIn ? true : false,
                  onChanged: (value) {
                    setState(() {
                      ref
                          .watch(instaLoginController.notifier)
                          .toCheckBox(value);
                      debugPrint('Checkbox Value: $value');
                    });
                  },
                  toGoToInversePage: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ));
                  },
                  onForgotPassword: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChangeInstaPassword(),
                    ));
                  },
                  isLoginWithFingerPrint: userloggedIn ? true : false,
                  toSignOrLogin: () {
                    userloggedIn
                        ? {
                            auth
                                .authenticate(
                              localizedReason: 'Authenticate With Biometrics',
                            )
                                .then((value) {
                              if (value) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const InstaDashboard(),
                                ));
                              }
                              debugPrint('INFO: To login with fingerprint');
                            })
                          }
                        : ref
                            .read(instaLoginController.notifier)
                            .signIn(usernameController.text,
                                passwordController.text)
                            .then((value) {
                            if (value) {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const InstaDashboard(),
                              ));
                            }
                            debugPrint(
                                'INFO: To login with email:${usernameController.text} and password: ${passwordController.text}');
                          });
                  },
                  anyWidget: userloggedIn
                      ? const SizedBox()
                      : AuthTextField(
                          icon: Icons.person_2_outlined,
                          hintT: 'Email',
                          hasSuffix: false,
                          controller: usernameController,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return MyStrings.enterYourEmail;
                            } else if (!MyStrings.emailValidatorRegExp
                                .hasMatch(value ?? '')) {
                              return MyStrings.invalidEmailMsg;
                            } else {
                              return null;
                            }
                          },
                        ),
                  anyWidget1: userloggedIn
                      ? Lottie.asset(
                          "assets/animation/fingerprint.json",
                          controller: _controller,
                          onLoaded: (composition) {
                            _controller
                              ..duration = composition.duration
                              ..repeat();
                          },
                        )
                      : AuthTextField(
                          isPassword: true,
                          icon: Icons.lock_outline_rounded,
                          hintT: 'Password',
                          hasSuffix: true,
                          controller: passwordController,
                        ),
                );
              }),
            ),
            if (loadingState == LoadingState.loading)
              const TransparentLoadingScreen(),
          ],
        );
      },
    );
  }
}
