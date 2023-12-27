import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class ServicesIconTabs extends StatelessWidget {
  final String imageIconPath;
  final String text;
  final bool isTapped;
  final void Function()? onTap;
  const ServicesIconTabs(
      {super.key,
      required this.imageIconPath,
      required this.text,
      this.isTapped = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.sp),
            width: 50.w,
            height: 45.h,
            decoration: BoxDecoration(
              color:
                  InstaColors.containerGradient.elementAt(2).withOpacity(0.2),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Image.asset(
              EnvAssets.getIconPath(imageIconPath),
              // width: 15.w,
              // height: 15.h,
              color: isTapped ? null : InstaColors.mildGrey,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 11.sp,
            ),
          ).afmPadding(EdgeInsets.symmetric(vertical: 5.h)),
        ],
      ),
    );
  }
}
