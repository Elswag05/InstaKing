import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class CustomButton extends StatelessWidget {
  final void Function()? toSignOrLogin;
  final String pageCTA;
  const CustomButton({super.key, required this.pageCTA, this.toSignOrLogin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('INFO: $pageCTA button has been pressed');
        toSignOrLogin!();
      },
      child: Container(
        height: 45.h,
        width: MediaQuery.of(context).size.width - 40.w,
        decoration: BoxDecoration(
          color: EnvColors.primaryColor[900],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          pageCTA,
          style: TextStyle(
            fontFamily: 'Montesserat',
            color: EnvColors.lightColor,
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
