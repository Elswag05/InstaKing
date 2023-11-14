import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_king/core/constants/env_assets.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/presentation/controllers/insta_dashboard_controller.dart';

BottomNavigationBarItem buildBottomNavigationBarItem(
  WidgetRef ref, {
  required String iconPath,
  required String label,
  required int index,
}) {
  final dashboardController = ref.watch(dashBoardControllerProvider);
  final selectedPageIndex = dashboardController.page;

  return BottomNavigationBarItem(
    icon: SvgPicture.asset(
      EnvAssets.getSvgPath(iconPath),
      width: 25.w,
      height: 25.h,
      // ignore: deprecated_member_use
      color: selectedPageIndex == index
          ? EnvColors.primaryColor
          : EnvColors.darkColor,
      semanticsLabel: label,
    ),
    // icon: Image.asset(
    //   EnvAssets.getIconPath(iconPath),
    //   width: 25.w,
    //   height: 25.h,
    //   color: selectedPageIndex == index
    //       ? EnvColors.primaryColor
    //       : EnvColors.darkColor,
    // ),
    label: label,
  );
}
