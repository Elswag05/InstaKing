// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class ProfileViewModel extends StatelessWidget {
  final String modelText;
  final void Function()? onTap;
  final Widget loadWidget;
  final String icon;
  final double iconDimension;
  final bool isError;
  final double padding;

  const ProfileViewModel({
    super.key,
    required this.modelText,
    this.onTap,
    this.loadWidget = const SizedBox(),
    required this.icon,
    this.iconDimension = 20,
    this.isError = false,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: padding.sp),
                  constraints: BoxConstraints(
                    minWidth: 40.w,
                    maxWidth: 40.w,
                    minHeight: 30.h,
                    maxHeight: 40.h,
                  ),
                  child: SvgPicture.asset(
                    EnvAssets.getSvgPath(icon),
                    width: iconDimension.w,
                    height: iconDimension.h,
                    // fit: BoxFit.none,
                    color: !isError
                        ? Theme.of(context).colorScheme.onBackground
                        : InstaColors.errorColor,
                  ).afmPadding(
                    EdgeInsets.only(right: 10.h),
                  ),
                ),
                Text(
                  modelText,
                  style: TextStyle(
                    fontFamily: 'Montesserat',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.sp,
              color: Theme.of(context).colorScheme.onSurface,
            ).afmPadding(
              EdgeInsets.only(right: 6.h),
            ),
          ],
        ),
      ),
    );
  }
}
