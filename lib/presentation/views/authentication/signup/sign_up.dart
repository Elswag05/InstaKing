import 'package:flutter/material.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/base_auth_view.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/text_form.dart';
import 'package:insta_king/presentation/views/authentication/login/login.dart';
import 'package:insta_king/presentation/views/dashboard/insta_dashboard.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseAuthView(
      pageName: "Create Account",
      callToActionFooterText: "Do you have an account?",
      inversePageName: "Sign in",
      callToActionText: '',
      checkBoxText: "I agree to the terms and policy",
      pageCTA: "Create Account",
      isLogin: false,
      anyWidget: const AuthTextField(
        icon: Icons.person_2_outlined,
        hintT: 'Email Address',
        hasSuffix: false,
      ),
      anyWidget1: const AuthTextField(
        icon: Icons.person_2_outlined,
        hintT: 'First Name',
        hasSuffix: false,
      ),
      anyWidget2: const AuthTextField(
        icon: Icons.person_2_outlined,
        hintT: 'Last Name',
        hasSuffix: false,
      ),
      anyWidget3: const AuthTextField(
        icon: Icons.person_2_outlined,
        hintT: 'Username',
        hasSuffix: false,
      ),
      anyWidget4: const AuthTextField(
        icon: Icons.phone_outlined,
        hintT: 'Phone Numbers',
        hasSuffix: false,
      ),
      anyWidget5: const AuthTextField(
        icon: Icons.lock_outline_rounded,
        hintT: 'Password',
        hasSuffix: true,
      ),
      anyWidget6: const AuthTextField(
        icon: Icons.person_2_outlined,
        hintT: 'Referral ID',
        hasSuffix: false,
      ),
      toGoToInversePage: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const InstaLogin(),
        ));
      },
      toSignOrLogin: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const InstaDashboard(),
        ));
      },
    );
  }
}
