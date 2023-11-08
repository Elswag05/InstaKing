import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class PersonalDetailModel extends StatelessWidget {
  final String leadTitle;
  final String hintT;
  final bool isPasswordT;
  const PersonalDetailModel(
      {super.key,
      required this.leadTitle,
      required this.hintT,
      this.isPasswordT = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          leadTitle,
          style: TextStyle(
            fontFamily: 'Montesserat',
            fontSize: 16.sp,
            color: EnvColors.darkColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          obscureText: isPasswordT,
          style: TextStyle(
            fontSize: 13.sp,
          ),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            hintText: hintT,
            hintStyle: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 13.sp,
              color: EnvColors.darkColor.withOpacity(0.5),
            ),
            fillColor: EnvColors.lightColor,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                width: 1.sp,
                color: EnvColors.darkColor.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                width: 1.sp,
                color: EnvColors.darkColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                width: 1.sp,
                color: EnvColors.darkColor.withOpacity(0.5),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                width: 1.sp,
                color: EnvColors.errorColor,
              ),
            ),
          ),
        ).afmPadding(EdgeInsets.only(top: 10.sp, bottom: 10.sp)),
      ],
    );
  }
}
