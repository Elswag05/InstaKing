import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/core/utils/my_strings.dart';
import 'package:insta_king/presentation/controllers/insta_login_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late final TextEditingController oldPassword;
  late final TextEditingController newPassword;
  late final TextEditingController confirmNewPassword;

  @override
  void initState() {
    super.initState();
    oldPassword = TextEditingController();
    newPassword = TextEditingController();
    confirmNewPassword = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    oldPassword.dispose();
    newPassword.dispose();
    confirmNewPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          backgroundColor: EnvColors.appBackgroundColor,
          body: Column(
            children: [
              const RecurringAppBar(appBarTitle: "Change Password")
                  .afmPadding(EdgeInsets.only(bottom: 10.h)),
              Container(
                color: EnvColors.lightColor,
                child: Column(
                  children: [
                    CollectPersonalDetailModel(
                      leadTitle: "Old password",
                      hintT: 'You old password',
                      isPasswordT: true,
                      controller: oldPassword,
                    ),
                    CollectPersonalDetailModel(
                      leadTitle: "New password",
                      hintT: 'You new password',
                      isPasswordT: true,
                      controller: newPassword,
                      validator: (value) {
                        RegExp oneUppercase = RegExp(r'^(?=.*?[A-Z])');
                        RegExp oneDigit = RegExp(r'^(?=.*?[0-9])');
                        RegExp oneSpecialChar =
                            RegExp(r'^(?=.*?[!@#\$&*-_:;"`%^./~])');
                        RegExp atLeastEight = RegExp(r'^.{8,}');
                        if (value!.isEmpty) {
                          return MyStrings.enterYourPassword_;
                        } else {
                          if (!oneUppercase.hasMatch(value)) {
                            return MyStrings.upperCaseMsg;
                          } else if (!oneSpecialChar.hasMatch(value)) {
                            return MyStrings.oneSpecialCharMsg;
                          } else if (!oneDigit.hasMatch(value)) {
                            return MyStrings.oneDigitMsg;
                          } else if (!atLeastEight.hasMatch(value)) {
                            return MyStrings.lessThanEightMsg;
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                    CollectPersonalDetailModel(
                      leadTitle: "Confirm password",
                      hintT: 'Re-enter your new password',
                      isPasswordT: true,
                      controller: confirmNewPassword,
                      validator: (value) {
                        if (value.toString() == newPassword.text) {
                          return null;
                        } else {
                          return MyStrings.wrongPass;
                        }
                      },
                    ),
                    CustomButton(
                      pageCTA: 'Save New Password',
                      toSignOrLogin: () {
                        ref
                            .read(instaLoginController.notifier)
                            .changePassword(
                              oldPassword.text,
                              newPassword.text,
                            )
                            .then(
                              (value) => Navigator.pop(context),
                            );
                      },
                    ).afmPadding(EdgeInsets.symmetric(vertical: 10.h))
                  ],
                ).afmPadding(
                  EdgeInsets.all(
                    25.sp,
                  ),
                ),
              )
                  .afmBorderRadius(
                    BorderRadius.circular(10.r),
                  )
                  .afmPadding(
                    EdgeInsets.symmetric(
                      horizontal: 20.sp,
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}
