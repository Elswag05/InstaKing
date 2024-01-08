import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/authentication/login/login.dart';
import 'package:insta_king/presentation/views/authentication/signup/sign_up.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';

class InstaAuthNavigator extends StatelessWidget {
  const InstaAuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    EnvAssets.getImagePath('instaking-logo'),
                    width: 60,
                    height: 60,
                  ),
                  Text(
                    'InstaKing',
                    style: TextStyle(
                      fontFamily: 'Monteserrat',
                      fontSize: 35.sp,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ).afmPadding(
                    EdgeInsets.only(
                      left: 5.h,
                      top: 5.h,
                    ),
                  ),
                ],
              ).afmPadding(
                EdgeInsets.only(top: 130.h),
              ),
              Text(
                "Africa's No.1 Social Media\n Marketing Service\n Provider.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Monteserrat',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ).afmPadding(
                EdgeInsets.only(top: 20.h),
              ),
            ],
          ),
          Column(
            children: [
              CustomButton(
                pageCTA: 'Create Account',
                buttonOnPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
              ).afmPadding(
                EdgeInsets.only(bottom: 10.h),
              ),
              CustomButton(
                pageCTA: 'Log In',
                color: InstaColors.lightColor,
                buttonTextColor: InstaColors.darkColor,
                buttonOnPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InstaLogin(),
                    ),
                  );
                },
              ).afmPadding(
                EdgeInsets.only(bottom: 20.h),
              ),
              RichText(
                // Controls visual overflow
                overflow: TextOverflow.clip,
                // Controls how the text should be aligned horizontally
                textAlign: TextAlign.center,
                // Control the text direction
                textDirection: TextDirection.rtl,
                // Whether the text should break at soft line breaks
                softWrap: true,
                // Maximum number of lines for the text to span
                maxLines: 2,
                // The number of font pixels for each logical pixel
                textScaler: TextScaler.noScaling,

                text: TextSpan(
                  text:
                      'By selecting one or the other, you are agreeing\n to our ',
                  style: TextStyle(
                    fontFamily: 'Monteserrat',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Terms of Services & Privacy Policy',
                      style: TextStyle(
                        fontFamily: 'Monteserrat',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ).afmPadding(
                EdgeInsets.only(
                  bottom: 20.h,
                  top: 15.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
