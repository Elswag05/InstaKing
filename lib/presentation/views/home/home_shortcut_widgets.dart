import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class HomeColumn extends StatelessWidget {
  final IconData shortcutIcon;
  final String shortcutText;
  final void Function()? onTap;
  const HomeColumn({
    super.key,
    required this.shortcutIcon,
    required this.shortcutText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            shortcutIcon,
            size: 40.sp,
            color: EnvColors.primaryColor,
          ),
          Text(
            shortcutText,
            style: TextStyle(
                color: EnvColors.darkColor,
                fontFamily: 'Montesserat',
                fontSize: 10.sp,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class ShortcutsTheWidget extends StatelessWidget {
  const ShortcutsTheWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shortcuts',
          style: TextStyle(
            color: EnvColors.darkColor,
            fontFamily: 'Montesserat',
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeColumn(
                  shortcutIcon: Icons.shopping_bag_rounded,
                  shortcutText: 'New Order',
                ),
                HomeColumn(
                  shortcutIcon: Icons.wallet_giftcard,
                  shortcutText: 'Fund Wallet',
                ),
                HomeColumn(
                  shortcutIcon: Icons.wifi,
                  shortcutText: 'Bill Payment',
                ),
              ],
            ).afmPadding(
                EdgeInsets.only(top: 20.sp, left: 25.sp, right: 25.sp)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeColumn(
                  shortcutIcon: Icons.transform,
                  shortcutText: 'Transactions',
                  onTap: () {},
                ),
                HomeColumn(
                  shortcutIcon: Icons.contact_emergency,
                  shortcutText: 'Refer And Earn',
                  onTap: () {},
                ),
                SizedBox(
                  width: 80.sp,
                  height: 40.sp,
                ),
              ],
            ).afmPadding(
                EdgeInsets.only(top: 20.sp, left: 25.sp, right: 25.sp)),
          ],
        )
      ],
    ).afmPadding(EdgeInsets.only(left: 25.sp, top: 20.sp));
  }
}
