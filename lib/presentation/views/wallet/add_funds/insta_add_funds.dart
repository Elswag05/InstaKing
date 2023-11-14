import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';
import 'package:insta_king/presentation/views/shared_widgets/small_cta.dart';
import 'package:insta_king/presentation/views/wallet/add_funds/account_details.dart';

class AddFunds extends StatelessWidget {
  const AddFunds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EnvColors.appBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const RecurringAppBar(
              appBarTitle: "Add Funds",
              hasLeading: false,
            ).afmPadding(EdgeInsets.only(bottom: 10.h)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.sp),
              color: EnvColors.primaryColor.withBlue(2).withOpacity(0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SmallCTA(
                    text: 'Bank Transfer',
                    backgroundColor: EnvColors.mildGrey,
                    textColor: EnvColors.lightColor,
                  )
                      .afmBorderRadius(BorderRadius.circular(6.r))
                      .afmPadding(EdgeInsets.only(top: 23.h)),
                  Divider(
                    thickness: 1.dg,
                    height: 1.h,
                  ).afmPadding(
                    EdgeInsets.symmetric(
                      vertical: 20.sp,
                    ),
                  ),
                  Text(
                    'Make payment into the account number below to fund your wallet automatically',
                    style: TextStyle(
                      color: EnvColors.mildGrey,
                      fontFamily: 'Montesserat',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ).afmPadding(
                    EdgeInsets.only(
                      bottom: 20.sp,
                    ),
                  ),
                  AccountDetails(),
                ],
              ),
            ).afmBorderRadius(BorderRadius.circular(20.r)).afmPadding(
                  EdgeInsets.only(
                    top: 20.sp,
                    left: 20.sp,
                    right: 20.sp,
                  ),
                ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.sp),
              color: EnvColors.lightColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SmallCTA(
                    text: 'Flutterwave',
                    backgroundColor: EnvColors.mildGrey,
                    textColor: EnvColors.lightColor,
                  )
                      .afmBorderRadius(BorderRadius.circular(6.r))
                      .afmPadding(EdgeInsets.only(top: 23.h)),
                  Divider(
                    thickness: 1.dg,
                    height: 1.h,
                  ).afmPadding(
                    EdgeInsets.symmetric(
                      vertical: 20.sp,
                    ),
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Flutter',
                        style: TextStyle(
                          fontFamily: 'Montesserat',
                          fontSize: 20.sp,
                          color: EnvColors.mildGrey,
                          fontWeight: FontWeight.w500,
                        ),
                        children: const <TextSpan>[
                          TextSpan(
                            text: 'wave',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ).afmPadding(EdgeInsets.only(bottom: 10.h)),
                  Center(
                    child: Text(
                      'You can deposit funds with Flutterwave. They will be automatically added into your account!',
                      style: TextStyle(
                        color: EnvColors.mildGrey,
                        fontFamily: 'Montesserat',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).afmPadding(EdgeInsets.all(10.h)),
                ],
              ),
            ).afmBorderRadius(BorderRadius.circular(20.r)).afmPadding(
                  EdgeInsets.all(
                    20.sp,
                  ),
                ),
          ],
        ).afmNeverScroll,
      ),
    );
  }
}
