import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';

class SmallCTA extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  const SmallCTA({
    super.key,
    required this.text,
    this.backgroundColor = InstaColors.primaryColor,
    this.textColor = InstaColors.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      width: 90.w,
      color: backgroundColor,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontFamily: 'Montesserat',
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
