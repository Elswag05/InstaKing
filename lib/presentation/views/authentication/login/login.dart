import 'package:flutter/material.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/base_auth_view.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/text_form.dart';
import 'package:insta_king/presentation/views/authentication/signup/sign_up.dart';
import 'package:insta_king/presentation/views/dashboard/insta_dashboard.dart';
import 'package:insta_king/presentation/views/home/insta_home.dart';

class InstaLogin extends StatelessWidget {
  const InstaLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseAuthView(
      pageName: 'Sign In',
      pageCTA: 'Log in',
      isLogin: true,
      callToActionText: 'Forgot Password',
      callToActionFooterText: "Don't have an account yet?",
      checkBoxText: "Remember me",
      inversePageName: 'Sign Up',
      toGoToInversePage: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SignUp(),
        ));
      },
      toSignOrLogin: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const InstaDashBoard(),
        ));
      },
      anyWidget: const AuthTextField(
        icon: Icons.person_2_outlined,
        hintT: 'First Name',
        hasSuffix: false,
      ),
      anyWidget1: const AuthTextField(
        icon: Icons.lock_outline_rounded,
        hintT: 'Password',
        hasSuffix: true,
      ),
    );
  }
}
