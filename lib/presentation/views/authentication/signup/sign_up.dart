import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_king/presentation/controllers/insta_signin_controller.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/base_auth_view.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/text_form.dart';
import 'package:insta_king/presentation/views/authentication/login/login.dart';
import 'package:insta_king/presentation/views/dashboard/insta_dashboard.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController referralController = TextEditingController();
    return Consumer(
      builder: (context, ref, child) {
        return BaseAuthView(
          pageName: "Create Account",
          callToActionFooterText: "Do you have an account?",
          inversePageName: "Sign in",
          callToActionText: '',
          checkBoxText: "I agree to the terms and policy",
          pageCTA: "Create Account",
          isLogin: false,
          anyWidget: AuthTextField(
            icon: Icons.person_2_outlined,
            hintT: 'Email Address',
            hasSuffix: false,
            controller: emailController,
          ),
          anyWidget1: AuthTextField(
            icon: Icons.person_2_outlined,
            hintT: 'First Name',
            hasSuffix: false,
            controller: firstNameController,
          ),
          anyWidget2: AuthTextField(
            icon: Icons.person_2_outlined,
            hintT: 'Last Name',
            hasSuffix: false,
            controller: lastNameController,
          ),
          anyWidget3: AuthTextField(
            icon: Icons.person_2_outlined,
            hintT: 'Username',
            hasSuffix: false,
            controller: userNameController,
          ),
          anyWidget4: AuthTextField(
            icon: Icons.phone_outlined,
            hintT: 'Phone Numbers',
            hasSuffix: false,
            controller: phoneNumberController,
          ),
          anyWidget5: AuthTextField(
            icon: Icons.lock_outline_rounded,
            hintT: 'Password',
            hasSuffix: true,
            controller: passwordController,
          ),
          anyWidget6: AuthTextField(
            icon: Icons.person_2_outlined,
            hintT: 'Referral ID',
            hasSuffix: false,
            controller: referralController,
          ),
          toGoToInversePage: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const InstaLogin(),
            ));
          },
          toSignOrLogin: () {
            debugPrint(
                'INFO: To Create an account with email:${emailController.text} and password: ${passwordController.text}');
            ref
                .read(instaSignUpController.notifier)
                .signUp(
                    firstNameController.text,
                    lastNameController.text,
                    emailController.text,
                    userNameController.text,
                    passwordController.text,
                    phoneNumberController.text,
                    referralController.text)
                .then(
              (value) {
                if (value) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const InstaDashboard(),
                  ));
                }
              },
            );
          },
        );
      },
    );
  }
}
