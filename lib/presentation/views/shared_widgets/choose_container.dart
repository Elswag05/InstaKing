import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class ChooseContainerFromDropDown extends StatelessWidget {
  final String headerText;
  final String hintText;
  final IconData displayIcon;
  const ChooseContainerFromDropDown(
      {super.key,
      required this.headerText,
      required this.hintText,
      this.displayIcon = Icons.keyboard_arrow_down_rounded});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          headerText,
          minFontSize: 14.sp,
          stepGranularity: 2.sp,
          style: TextStyle(
            fontFamily: 'Montesserat',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(
              width: 0.5.sp,
              color: InstaColors.darkColor,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                hintText,
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ).afmPadding(EdgeInsets.only(left: 10.w)),
              Icon(
                displayIcon,
                size: 20.sp,
              ).afmPadding(EdgeInsets.only(right: 6.h)),
            ],
          ),
        ).afmPadding(EdgeInsets.only(top: 10.sp, bottom: 10.sp)),
      ],
    );
  }
}
