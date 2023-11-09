import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_assets.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/order_history/place_order.dart';

class HomeColumn extends StatelessWidget {
  final String shortcutIcon;
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
          ImageIcon(
            AssetImage(
              EnvAssets.getIconPath(shortcutIcon),
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeColumn(
                  shortcutIcon: 'trolley',
                  shortcutText: 'New Order',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PlaceOrder(),
                      ),
                    );
                  },
                ),
                HomeColumn(
                  shortcutIcon: 'piggybank',
                  shortcutText: 'Fund Wallet',
                  onTap: () {},
                ),
                HomeColumn(
                  shortcutIcon: 'save-money',
                  shortcutText: 'Bill Payment',
                  onTap: () {},
                ),
              ],
            ).afmPadding(EdgeInsets.only(top: 20.sp, right: 25.sp)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeColumn(
                  shortcutIcon: 'money-transfer',
                  shortcutText: 'Transactions',
                  onTap: () {},
                ),
                HomeColumn(
                  shortcutIcon: 'giftbox',
                  shortcutText: 'Refer And Earn',
                  onTap: () {},
                ),
                SizedBox(
                  width: 80.sp,
                  height: 40.sp,
                ),
              ],
            ).afmPadding(EdgeInsets.only(top: 20.sp, right: 25.sp)),
          ],
        )
      ],
    ).afmPadding(EdgeInsets.only(left: 25.sp, top: 20.sp));
  }
}
