import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/presentation/controllers/insta_dashboard_controller.dart';
import 'package:insta_king/presentation/views/add_funds/add_insta_funds.dart';
import 'package:insta_king/presentation/views/dashboard/bottom_navigation_bar_item.dart';
import 'package:insta_king/presentation/views/home/insta_home.dart';
import 'package:insta_king/presentation/views/order_history/insta_order.dart';
import 'package:insta_king/presentation/views/profile/insta_profile.dart';

class InstaDashboard extends HookConsumerWidget {
  const InstaDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardController = ref.watch(dashBoardControllerProvider);
    final selectedPageIndex = dashboardController.page;

    return Scaffold(
      backgroundColor: EnvColors.lightColor,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10.h,
        showUnselectedLabels: true,
        currentIndex: selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: EnvColors.lightColor,
        selectedFontSize: 12.sp,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
        ),
        unselectedFontSize: 11.sp,
        unselectedLabelStyle: TextStyle(
          color: EnvColors.darkColor,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
        ),
        selectedIconTheme: IconThemeData(
          size: 30.sp,
          color: EnvColors.primaryColor, // Color for selected icons
        ),
        onTap: (value) {
          ref.read(dashBoardControllerProvider.notifier).switchPage(value);
        },
        items: [
          buildBottomNavigationBarItem(
            ref,
            iconPath: 'home',
            label: 'Home',
            index: 0,
          ),
          buildBottomNavigationBarItem(
            ref,
            iconPath: 'bag',
            label: 'Order History',
            index: 1,
          ),
          buildBottomNavigationBarItem(
            ref,
            iconPath: 'wallet',
            label: 'Wallet',
            index: 2,
          ),
          buildBottomNavigationBarItem(
            ref,
            iconPath: 'user (1)',
            label: 'Profile',
            index: 3,
          ),
        ],
      ),
      body: [
        const InstaHome(),
        const InstaOrderHistory(),
        const InstaWallet(),
        const InstaProfile(),
      ][selectedPageIndex],
    );
  }
}
