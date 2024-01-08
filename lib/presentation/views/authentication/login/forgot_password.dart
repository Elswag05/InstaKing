import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/presentation/controllers/insta_login_controller.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/base_auth_view.dart';
import 'package:insta_king/presentation/views/authentication/auth_shared/text_form.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'package:insta_king/utils/locator.dart';

class ChangeInstaPassword extends StatefulWidget {
  const ChangeInstaPassword({super.key});

  @override
  State<ChangeInstaPassword> createState() => _ChangeInstaPasswordState();
}

class _ChangeInstaPasswordState extends State<ChangeInstaPassword> {
  late final TextEditingController emailController;
  late final TextEditingController userNameController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    userNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final loadingState = ref.watch(instaLoginController).loadingState;
        return Stack(
          children: [
            BaseAuthView(
              pageName: 'Forgot Password',
              pageCTA: 'Reset Password',
              inversePageName: '',
              callToActionText: '',
              callToActionFooterText: '',
              checkBoxText: '',
              isLogin: true,
              isForgotPassword: true,
              toGoToInversePage: () {},
              toPerformAuthAction: () {
                setState(() {});
                ref
                    .read(instaLoginController.notifier)
                    .resetPassword(
                      emailController.text,
                      userNameController.text,
                    )
                    .then(
                  (value) {
                    if (value) {
                      Navigator.pop(context);
                      Timer(
                        const Duration(seconds: 5),
                        () {
                          locator<ToastService>().showSuccessToast(
                            'Try loggin in again!',
                          );
                        },
                      );
                    }
                  },
                );
              },
              anyWidget: AuthTextField(
                icon: Icons.person_2_outlined,
                hintT: 'Enter Your email',
                hasSuffix: false,
                controller: emailController,
                isPassword: false,
              ),
            ),
            if (loadingState == LoadingState.loading)
              const TransparentLoadingScreen(),
          ],
        );
      },
    );
  }
}
