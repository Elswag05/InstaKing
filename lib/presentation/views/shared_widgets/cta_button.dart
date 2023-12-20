// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class CustomButton extends StatelessWidget {
  final bool agreeTC;
  final void Function()? toSignOrLogin;
  final String pageCTA;
  final Color color;
  final Color buttonTextColor;
  double height;
  CustomButton({
    super.key,
    this.agreeTC = false,
    this.toSignOrLogin,
    required this.pageCTA,
    this.color = InstaColors.primaryColor,
    this.height = 45,
    this.buttonTextColor = InstaColors.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ignore: avoid_print
        print('INFO: $pageCTA button has been pressed');
        toSignOrLogin!();
      },
      child: Container(
        height: height.h,
        width: MediaQuery.of(context).size.width - 40.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          pageCTA,
          style: TextStyle(
            fontFamily: 'Montesserat',
            color: buttonTextColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ).afmCenter,
      ).afmBorderRadius(
        BorderRadius.circular(10.r),
      ),
    );
  }
}
