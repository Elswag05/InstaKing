import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_king/core/constants/env_assets.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_categories_controller.dart';
import 'package:insta_king/presentation/controllers/insta_dashboard_controller.dart';
import 'package:insta_king/presentation/controllers/insta_transactions_controller.dart';
import 'package:insta_king/presentation/views/bill_payment/main_bill_payment.dart';
import 'package:insta_king/presentation/views/order/place_order/place_order.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/refer_and_earn/refer_and_earn.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_king/presentation/views/services/insta_services.dart';
import 'package:insta_king/presentation/views/transactions/insta_transactions.dart';

class HomeColumn extends StatelessWidget {
  final String shortcutIcon;
  final String shortcutText;
  final bool services;
  final void Function()? onTap;
  const HomeColumn({
    super.key,
    required this.shortcutIcon,
    required this.shortcutText,
    this.onTap,
    this.services = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !services
              ? SvgPicture.asset(
                  EnvAssets.getSvgPath(shortcutIcon),
                  width: 30.w,
                  height: 30.h,
                  // ignore: deprecated_member_use
                  color: InstaColors.primaryColor,
                  semanticsLabel: shortcutText,
                )
              : Icon(
                  Icons.storage_sharp,
                  size: 30.h,
                  color: InstaColors.primaryColor,
                ),
          Text(
            shortcutText,
            style: TextStyle(
                fontFamily: 'Montesserat',
                fontSize: 10.sp,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class ShortcutsTheWidget extends ConsumerWidget {
  const ShortcutsTheWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void setPageIndexToTwo() {
      final value = ref.watch(dashBoardControllerProvider);
      value.switchPage(2);
      //value.dispose();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: TextStyle(
            fontFamily: 'Montesserat',
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                HomeColumn(
                  shortcutIcon: 'Place Order',
                  shortcutText: 'Place Order',
                  onTap: () {
                    Future.delayed(Duration.zero, () async {
                      ref
                          .read(instaCategoriesController.notifier)
                          .toGetAllCategories;
                    });
                    ref.read(instaCategoriesController).toGetAllCategories();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PlaceOrder(),
                      ),
                    );
                  },
                ),
                HomeColumn(
                  shortcutIcon: 'wallet',
                  shortcutText: 'Fund Wallet',
                  onTap: () {
                    setPageIndexToTwo();
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const InstaWallet(),
                    //   ),
                    // );
                    // ignore: avoid_print
                    debugPrint('Going to the Wallet screen');
                  },
                ),
                HomeColumn(
                  shortcutIcon: 'wifi',
                  shortcutText: 'Bill Payment',
                  onTap: () {
                    Future.delayed(Duration.zero, () async {}).then((value) => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MainBillPayment(),
                            ),
                          )
                        });
                  },
                ),
              ],
            ).afmPadding(EdgeInsets.only(top: 20.sp, right: 25.sp)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                HomeColumn(
                  shortcutIcon: 'Transactioons',
                  shortcutText: 'Transactions',
                  onTap: () {
                    Future.delayed(Duration.zero, () async {
                      await ref
                          .read(instaTransactionController)
                          .getTransactions(1);
                    }).then((value) => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const InstaTransactions(),
                            ),
                          )
                        });
                  },
                ),
                HomeColumn(
                  shortcutIcon: 'Refer&Earn',
                  shortcutText: 'Refer & Earn',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ReferAndEarn(),
                      ),
                    );
                  },
                ),
                HomeColumn(
                  shortcutIcon: 'Services',
                  shortcutText: 'Services',
                  services: true,
                  onTap: () {
                    Future.delayed(Duration.zero, () async {
                      await ref
                          .read(instaCategoriesController)
                          .toGetAllServiceDetail();
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const InstaServices(),
                      ),
                    );
                  },
                ).afmPadding(EdgeInsets.only(left: 20.sp)),
              ],
            ).afmPadding(EdgeInsets.only(top: 20.sp, right: 35.sp)),
          ],
        )
      ],
    ).afmPadding(EdgeInsets.only(left: 25.sp, top: 20.sp, bottom: 15.h));
  }
}
