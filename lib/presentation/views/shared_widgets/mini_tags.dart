import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class MiniTags extends StatelessWidget {
  final String textOnTag;
  const MiniTags({super.key, required this.textOnTag});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      //width: 80.w,
      padding: EdgeInsets.all(5.sp),
      decoration: BoxDecoration(
        border: Border.all(
          color: EnvColors.primaryColor,
          width: 1.sp,
        ),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Center(
        child: Text(
          textOnTag,
          style: TextStyle(
            color: EnvColors.primaryColor,
            fontSize: 12.sp,
            letterSpacing: 0.5.w,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ).afmPadding(EdgeInsets.only(right: 10.w));
  }
}
