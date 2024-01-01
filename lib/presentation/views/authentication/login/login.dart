import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class InstaLogin extends ConsumerStatefulWidget {
  const InstaLogin({super.key});

  @override
  ConsumerState<InstaLogin> createState() => _InstaLoginState();
}

class _InstaLoginState extends ConsumerState<InstaLogin>
    with TickerProviderStateMixin {
  late final TextEditingController userEmailController;
  late final TextEditingController passwordController;
  late final LocalAuthentication auth;
//  bool _supportState = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    userEmailController = TextEditingController();
    passwordController = TextEditingController();
    auth = LocalAuthentication();
    // auth.isDeviceSupported().then((bool isSupported) => setState(() {
    //       _supportState = isSupported;
    //     }));
    userEmailController.text =
        ref.read(dashBoardControllerProvider.notifier).userEmail;
  }

  @override
  void dispose() {
    _controller.dispose();
    userEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        Future dash = ref.read(dashBoardControllerProvider.notifier).getEmail();
        dash;

        bool userloggedIn =
            ref.read(dashBoardControllerProvider.notifier).isLoggedIn;
        // final bool userloggedIn =
        //     ref.read(dashBoardControllerProvider.notifier).isLoggedIn;
        final instaLoginState = ref.watch(instaLoginController);
        final LoadingState loadingState = instaLoginState.loadingState;

        return Stack(
          children: [
            FutureBuilder(
              future: dash,
              builder: ((context, snapshot) {
                return BaseAuthView(
                  pageName: ' Sign In',
                  pageCTA: userloggedIn ? 'Login with fingerprint' : 'Log in',
                  isLogin: true,
                  callToActionText: userloggedIn ? "" : 'Forgot Password',
                  callToActionFooterText: userloggedIn
                      ? "Need another way?"
                      : "Don't have an account yet?",
                  checkBoxText: userloggedIn ? "" : "Remember me",
                  inversePageName:
                      userloggedIn ? "  Use details instead" : ' Sign Up',
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
                    userloggedIn
                        ? {
                            setState(() {
                              userloggedIn = false;
                            }),
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const InstaLogin()))
                          }
                        : {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ))
                          };
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
                            _authenticate().then((value) {
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
                            .signIn(userEmailController.text,
                                passwordController.text)
                            .then((value) {
                            if (value) {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const InstaDashboard(),
                              ));
                            }
                            debugPrint(
                                'INFO: To login with email:${userEmailController.text} and password: ${passwordController.text}');
                          });
                  },
                  anyWidget: userloggedIn
                      ? const SizedBox()
                      : AuthTextField(
                          icon: Icons.person_2_outlined,
                          hintT: 'Email',
                          hasSuffix: false,
                          controller: userEmailController,
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

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    debugPrint("List of biometrics: $availableBiometrics");
    if (!mounted) {
      return;
    }
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
