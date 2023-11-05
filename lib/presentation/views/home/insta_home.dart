import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/home/home_card_widgets.dart';
import 'package:insta_king/presentation/views/home/home_container_widget.dart';
import 'package:insta_king/presentation/views/home/home_head.dart';
import 'package:insta_king/presentation/views/home/home_shortcut_widgets.dart';
import 'package:insta_king/presentation/views/profile/insta_profile.dart';

class InstaHome extends StatelessWidget {
  const InstaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: EnvColors.appBackgroundColor,
        body: Padding(
          padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 5.sp),
          child: Column(
            children: [
              HomeHeaderWidget(
                username: 'John',
                onNotificationsTap: () {},
                onProfileTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const InstaProfile(),
                    ),
                  );
                },
              ).afmPadding(EdgeInsets.only(bottom: 20.h)),
              HomeContainer(
                backgroundColor: EnvColors.mildGrey,
                child: Padding(
                  padding: EdgeInsets.only(left: 18.sp, top: 3.sp, right: 18.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HomeCardBalance(
                            balanceString: 'Total Balance',
                            balance: 0.00,
                            toHideBalance: () {},
                          ),
                          HomeCardBalance(
                            balanceString: 'Affiliate Balance',
                            balance: 0.00,
                            toHideBalance: () {},
                          )
                        ],
                      ),
                      Container(
                        height: 25.h,
                        width: 90.w,
                        color: EnvColors.primaryColor,
                        child: Center(
                          child: Text(
                            'Fund Wallet',
                            style: TextStyle(
                              color: EnvColors.lightColor,
                              fontFamily: 'Montesserat',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                          .afmBorderRadius(BorderRadius.circular(6.r))
                          .afmPadding(EdgeInsets.only(top: 23.h)),
                    ],
                  ),
                ),
              )
                  .afmBorderRadius(BorderRadius.circular(24.r))
                  .afmPadding(EdgeInsets.only(bottom: 25.h)),
              HomeContainer(
                backgroundColor: EnvColors.lightColor,
                height: 160.h,
                child: const ShortcutsTheWidget(),
              )
                  .afmBorderRadius(BorderRadius.circular(24.r))
                  .afmPadding(EdgeInsets.only(bottom: 25.h)),
              Stack(
                children: [
                  HomeContainer(
                    height: 150.h,
                    backgroundColor: EnvColors.lightColor,
                  )
                      .afmBorderRadius(BorderRadius.circular(24.r))
                      .afmPadding(EdgeInsets.only(bottom: 20.h)),
                  Container(
                    height: 40.h,
                    width: MediaQuery.of(context).size.width - 40.sp,
                    color: EnvColors.mildGrey,
                    padding: EdgeInsets.only(left: 25.sp, top: 15.sp),
                    child: Text(
                      'Latest Transaction',
                      style: TextStyle(
                        color: EnvColors.lightColor,
                        fontFamily: 'Montesserat',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ).afmBorderRadius(BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r))),
                ],
              ),
            ],
          ),
        ).afmNeverScroll,
      ),
    );
  }
}
