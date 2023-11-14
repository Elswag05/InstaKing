import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
          icon: SvgPicture.asset(
            EnvAssets.getSvgPath('Search'),
            width: 20.w,
            height: 20.h,
            // ignore: deprecated_member_use
            color: EnvColors.darkColor,
            semanticsLabel: 'Search',
          ),
          onPressed: () {
            // ignore: avoid_print
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
