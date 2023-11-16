import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_king/core/utils/my_strings.dart';
import 'package:insta_king/presentation/controllers/insta_login_controller.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/base_auth_view.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/text_form.dart';
import 'package:insta_king/presentation/views/authentication/signup/sign_up.dart';
import 'package:insta_king/presentation/views/dashboard/insta_dashboard.dart';

class InstaLogin extends StatefulWidget {
  const InstaLogin({Key? key}) : super(key: key);

  @override
  State<InstaLogin> createState() => _InstaLoginState();
}

class _InstaLoginState extends State<InstaLogin> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return BaseAuthView(
          pageName: 'Sign In',
          pageCTA: 'Log in',
          isLogin: true,
          callToActionText: 'Forgot Password',
          callToActionFooterText: "Don't have an account yet?",
          checkBoxText: "Remember me",
          inversePageName: 'Sign Up',
          checked: ref.watch(instaLoginController.notifier).isBoxChecked,
          onChanged: (value) {
            setState(() {
              ref.watch(instaLoginController.notifier).toCheckBox(value);
            });
          },
          toGoToInversePage: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SignUp(),
            ));
          },
          toSignOrLogin: () {
            print('INFO: To login with email:' +
                usernameController.text +
                'and password: ' +
                passwordController.text);
            ref
                .read(instaLoginController.notifier)
                .signIn(usernameController.text, passwordController.text)
                .then((value) {
              if (value) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const InstaDashboard(),
                ));
              }
            });
          },
          anyWidget: AuthTextField(
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
          anyWidget1: AuthTextField(
            isPassword: true,
            icon: Icons.lock_outline_rounded,
            hintT: 'Password',
            hasSuffix: true,
            controller: passwordController,
          ),
        );
      },
    );
  }
}
