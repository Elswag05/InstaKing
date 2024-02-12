import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_assets.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class ProfileViewModel extends StatelessWidget {
  final String modelText;
  final void Function()? onTap;
  final Widget loadWidget;
  final String icon;

  const ProfileViewModel({
    super.key,
    required this.modelText,
    this.onTap,
    this.loadWidget = const SizedBox(),
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
            Image.asset(
                EnvAssets.getSvgPath(icon),
                width: 20.w,
                height: 20.h,
              ).afmPadding(
                EdgeInsets.only(right: 6.h),
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
            size: 20.sp,
            color: Theme.of(context).colorScheme.onSurface,
          ).afmPadding(
            EdgeInsets.only(right: 6.h),
          ),
        ],
      ),
    );
  }
}
