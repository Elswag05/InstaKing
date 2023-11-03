import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/presentation/controllers/insta_dashboard_controller.dart';
import 'package:insta_king/presentation/views/add_funds/add_insta_funds.dart';
import 'package:insta_king/presentation/views/home/insta_home.dart';
import 'package:insta_king/presentation/views/order_history/insta_order.dart';
import 'package:insta_king/presentation/views/profile/insta_profile.dart';

class InstaDashBoard extends HookConsumerWidget {
  const InstaDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardVM = ref.watch(dashBoardControllerProvider);
    return Scaffold(
      backgroundColor: EnvColors.appBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10.h,
        showUnselectedLabels: true,
        currentIndex: dashboardVM.page,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        onTap: (value) =>
            ref.read(dashBoardControllerProvider.notifier).switchPage(value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            // Image.asset(
            //   EnvAssets.getIconPath('house'),
            //   width: 30.w,
            //   height: 30.h,
            //   color: EnvColors.darkColor, // Color for unselected icons
            // ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: 'Order History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: [
        const InstaHome(),
        const InstaOrderHistory(),
        const InstaWallet(),
        const InstaProfile(),
      ][dashboardVM.page],
    );
  }
}
