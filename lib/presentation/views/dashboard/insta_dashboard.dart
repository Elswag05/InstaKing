import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/data/controllers/insta_dashboard_controller.dart';
import 'package:insta_king/presentation/views/bill_payment/main_bill_payment.dart';
import 'package:insta_king/presentation/views/wallet/insta_wallet.dart';
import 'package:insta_king/presentation/views/dashboard/bottom_navigation_bar_item.dart';
import 'package:insta_king/presentation/views/home/insta_home.dart';
//Todo: Uncomment this line
// import 'package:insta_king/presentation/views/order/insta_order.dart';
import 'package:insta_king/presentation/views/profile/insta_profile.dart';
import 'package:flutter/cupertino.dart';

class InstaDashboard extends HookConsumerWidget {
  const InstaDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<NavigatorState> homeNavigatorKey =
        GlobalKey<NavigatorState>();
    //Todo: uncomment this line
    // final GlobalKey<NavigatorState> myOrderNavigatorKey =
    //     GlobalKey<NavigatorState>();
    final GlobalKey<NavigatorState> billsNavigatorKey =
        GlobalKey<NavigatorState>();
    final GlobalKey<NavigatorState> walletNavigatorKey =
        GlobalKey<NavigatorState>();
    final GlobalKey<NavigatorState> profileNavigatorKey =
        GlobalKey<NavigatorState>();
    debugPrint('Consumer rebuilt: ${DateTime.now()}');
    // Access the InstaDashboardController using the provider
    final dashboardController = ref.watch(dashBoardControllerProvider);
    final selectedPageIndex = dashboardController.myPage;
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: selectedPageIndex,
        onTap: (value) {
          dashboardController.switchPage(value);
        },
        activeColor: InstaColors.primaryColor,
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        height: 60.h,
        items: <BottomNavigationBarItem>[
          buildBottomNavigationBarItem(
            ref,
            context,
            iconPath: 'Home',
            label: 'Home',
            index: 0,
          ),
          //Todo: uncomment this line
          // buildBottomNavigationBarItem(
          //   ref,
          //   context,
          //   iconPath: 'Order-History',
          //   label: 'My Orders',
          //   index: 1,
          // ),
          buildBottomNavigationBarItem(
            ref,
            context,
            iconPath: 'wifi',
            label: 'Pay Bills',
            index: 1,
          ),
          buildBottomNavigationBarItem(
            ref,
            context,
            iconPath: 'Wallet (1)',
            label: 'Wallet',
            index: 2,
          ),
          buildBottomNavigationBarItem(
            ref,
            context,
            iconPath: 'Profile',
            label: 'Profile',
            index: 3,
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            homeNavigatorKey.currentState?.popUntil(
              (route) => route.isFirst,
            );
            return CupertinoTabView(
              key: homeNavigatorKey,
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: InstaHome(),
                );
              },
            );
          //Todo: uncomment this line
          //todo: do not forget to turn the 1's to 2 and onward
          // case 1:
          //   myOrderNavigatorKey.currentState
          //       ?.popUntil((route) => route.isFirst);
          //   return CupertinoTabView(
          //     builder: (context) {
          //       return const CupertinoPageScaffold(
          //         child: InstaOrderHistory(),
          //       );
          //     },
          //   );
          case 1:
            billsNavigatorKey.currentState?.popUntil((route) => route.isFirst);
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: MainBillPayment(),
                );
              },
            );
          case 2:
            walletNavigatorKey.currentState?.popUntil((route) => route.isFirst);
            return CupertinoTabView(
              key: walletNavigatorKey,
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: InstaWallet(),
                );
              },
            );
          case 3:
            profileNavigatorKey.currentState
                ?.popUntil((route) => route.isFirst);
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: InstaProfile(),
                );
              },
            );
          default:
            return CupertinoTabView(
              key: profileNavigatorKey,
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: InstaHome(),
                );
              },
            );
        }
      },
    );
  }
}
