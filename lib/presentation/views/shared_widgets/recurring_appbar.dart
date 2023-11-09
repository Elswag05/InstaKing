import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class RecurringAppBar extends StatelessWidget {
  final String appBarTitle;
  final bool hasLeading;
  const RecurringAppBar(
      {super.key, required this.appBarTitle, this.hasLeading = true});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          hasLeading
              ? IconButton(
                  splashColor: EnvColors.mildGrey,
                  splashRadius: 20.r,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip: 'return to previous page',
                  highlightColor: EnvColors.primaryColor,
                  color: EnvColors.mildGrey,
                )
              : SizedBox(
                  width: 20.r,
                ),
          Text(
            appBarTitle,
            style: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 20.sp,
              color: EnvColors.darkColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ).afmPadding(EdgeInsets.only(left: 10.w)),
    );
  }
}

class SharedDropDown extends StatelessWidget {
  final String text;
  final String hintText;
  const SharedDropDown({super.key, required this.text, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Montesserat',
            fontSize: 16.sp,
            color: EnvColors.darkColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: EnvColors.lightColor,
            border: Border.all(
              color: EnvColors.darkColor.withOpacity(0.5),
              width: 1.sp,
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
                  color: EnvColors.darkColor.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
              ).afmPadding(EdgeInsets.only(left: 10.w)),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20.sp,
                color: EnvColors.darkColor.withOpacity(0.5),
              ).afmPadding(EdgeInsets.only(right: 6.h)),
            ],
          ),
        ).afmPadding(EdgeInsets.only(top: 10.sp, bottom: 10.sp)),
      ],
    );
  }
}
