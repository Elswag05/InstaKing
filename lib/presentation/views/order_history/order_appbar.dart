import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_assets.dart';
import 'package:insta_king/core/constants/env_colors.dart';

class OrderAppBar extends StatelessWidget {
  final String text;
  const OrderAppBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Montesserat',
            fontSize: 20.sp,
            color: EnvColors.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          splashColor: EnvColors.darkColor,
          splashRadius: 25.r,
          icon: Image.asset(
            EnvAssets.getIconPath('loupe'),
            width: 25.w,
            height: 25.h,
            color: EnvColors.darkColor,
          ),
          onPressed: () {
            print('INFO: You just prompted search');
          },
          tooltip: 'search',
          highlightColor: EnvColors.primaryColor,
          color: EnvColors.mildGrey,
        ), //.afmPadding(EdgeInsets.only(left: 10.w)),
      ],
    );
  }
}
