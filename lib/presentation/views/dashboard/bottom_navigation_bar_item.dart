import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_king/core/constants/env_assets.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/data/controllers/insta_dashboard_controller.dart';

BottomNavigationBarItem buildBottomNavigationBarItem(
  WidgetRef ref,
  BuildContext context, {
  required String iconPath,
  required String label,
  required int index,
}) {
  final dashboardController = ref.watch(dashBoardControllerProvider);
  final selectedPageIndex = dashboardController.page;

  return BottomNavigationBarItem(
    icon: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          EnvAssets.getSvgPath(iconPath),
          width: 23.w,
          height: 23.h,
          // ignore: deprecated_member_use
          color: selectedPageIndex == index
              ? InstaColors.primaryColor
              : Theme.of(context).colorScheme.onSurface,
          semanticsLabel: label,
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontFamily: 'Montesserat',
            color: selectedPageIndex == index
                ? InstaColors.primaryColor
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    ),
    label: '',
  );
}
