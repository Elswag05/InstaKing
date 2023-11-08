import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class ProfileViewModel extends StatelessWidget {
  final String modelText;
  final void Function()? onTap;
  const ProfileViewModel({super.key, required this.modelText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            modelText,
            style: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 14.sp,
              color: EnvColors.darkColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20.sp,
            color: EnvColors.mildGrey,
          ).afmPadding(EdgeInsets.only(right: 6.h)),
        ],
      ),
    );
  }
}
