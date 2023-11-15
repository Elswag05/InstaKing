import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';

class BaseAuthView extends StatelessWidget {
  final String pageName;
  final String pageCTA;
  final String inversePageName;
  final String callToActionText;
  final String callToActionFooterText;
  final String checkBoxText;
  final bool isLogin;
  final void Function()? toGoToInversePage;
  final Widget? anyWidget;
  final Widget? anyWidget1;
  final Widget? anyWidget2;
  final Widget? anyWidget3;
  final Widget? anyWidget4;
  final Widget? anyWidget5;
  final Widget? anyWidget6;
  final void Function()? toSignOrLogin;

  const BaseAuthView({
    Key? key,
    required this.pageName,
    required this.callToActionText,
    required this.callToActionFooterText,
    required this.checkBoxText,
    required this.inversePageName,
    this.anyWidget = const SizedBox(),
    this.anyWidget1 = const SizedBox(),
    this.anyWidget2 = const SizedBox(),
    this.anyWidget3 = const SizedBox(),
    this.anyWidget4 = const SizedBox(),
    this.anyWidget5 = const SizedBox(),
    this.anyWidget6 = const SizedBox(),
    required this.pageCTA,
    required this.isLogin,
    required this.toGoToInversePage,
    this.toSignOrLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 80.h,
                ),
                Text(
                  pageName,
                  style: TextStyle(
                    fontFamily: 'Montesserat',
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ).afmCenter,
                SizedBox(
                  height: 20.h,
                ),
                anyWidget == null ? const SizedBox() : anyWidget!,
                anyWidget1 == null ? const SizedBox() : anyWidget1!,
                anyWidget2 == null ? const SizedBox() : anyWidget2!,
                anyWidget3 == null ? const SizedBox() : anyWidget3!,
                anyWidget4 == null ? const SizedBox() : anyWidget4!,
                anyWidget5 == null ? const SizedBox() : anyWidget5!,
                anyWidget6 == null ? const SizedBox() : anyWidget6!,
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.sp, right: 25.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (checkbox) {},
                        ),
                        Text(
                          checkBoxText,
                          style: TextStyle(
                            fontFamily: 'Montesserat',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  isLogin
                      ? GestureDetector(
                          child: Text(
                            callToActionText,
                            style: TextStyle(
                              fontFamily: 'Montesserat',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // GestureDetector(
            //   child: Column(
            //     children: [
            //       Image.asset(
            //         EnvAssets.getIconPath('fingerprint'),
            //         width: 60.w,
            //         height: 60.h,
            //       ),
            //       SizedBox(
            //         height: 5.h,
            //       ),
            //       Text(
            //         'Login with fingerprint',
            //         style: TextStyle(
            //           fontFamily: 'Montesserat',
            //           fontSize: 12.sp,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 40.h,
            // ),
            CustomButton(
              pageCTA: pageCTA,
              toSignOrLogin: toSignOrLogin,
            ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: toGoToInversePage,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    callToActionFooterText,
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      fontSize: 14.sp,
                      color: EnvColors.darkColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    inversePageName,
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      color: EnvColors.primaryColor[700],
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).afmNeverScroll,
      ),
    );
  }
}
