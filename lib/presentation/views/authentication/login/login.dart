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

class InstaLogin extends ConsumerStatefulWidget {
  const InstaLogin({super.key});

  @override
  ConsumerState<InstaLogin> createState() => _InstaLoginState();
}

class _InstaLoginState extends ConsumerState<InstaLogin>
    with TickerProviderStateMixin {
  late final TextEditingController userEmailController;
  late final TextEditingController passwordController;
  late final instaLoginState = ref.watch(instaLoginController);

  DashBoardController dash = DashBoardController();

  @override
  void initState() {
    super.initState();
    userEmailController = TextEditingController();
    passwordController = TextEditingController();
    dash = ref.read(dashBoardControllerProvider.notifier);
    userEmailController.text = ref.read(dashBoardControllerProvider).userEmail;
  }

  @override
  void dispose() {
    userEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoadingState loadingState = instaLoginState.loadingState;
    return Consumer(
      builder: (context, ref, child) {
        return Stack(
          children: [
            FutureBuilder(
              future: dash.getEmail(),
              builder: ((context, snapshot) {
                return BaseAuthView(
                  pageName: ' Sign In',
                  pageCTA: 'Log in',
                  isLogin: true,
                  callToActionText: 'Forgot Password ?',
                  callToActionFooterText: "Don't have an account yet?",
                  checkBoxText: "Remember me",
                  inversePageName: ' Sign Up',
                  checked: ref.watch(instaLoginController).isBoxChecked,
                  isForgotPassword: false,
                  onChanged: (value) {
                    setState(() {
                      ref.watch(instaLoginController).toCheckBox(value);
                      debugPrint('Checkbox Value: $value');
                    });
                  },
                  toGoToInversePage: () {
                    {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ));
                    }
                  },
                  onForgotPassword: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChangeInstaPassword(),
                    ));
                  },
                  isLoginWithFingerPrint: false,
                  toPerformAuthAction: () {
                    setState(() {});
                    ref
                        .read(instaLoginController.notifier)
                        .signIn(
                            userEmailController.text, passwordController.text)
                        .then((value) {
                      if (value) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const InstaDashboard(),
                        ));
                      }
                      debugPrint(
                          'INFO: To login with email:${userEmailController.text} and password: ${passwordController.text}');
                    });
                  },
                  anyWidget: AuthTextField(
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
                  anyWidget1: AuthTextField(
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
