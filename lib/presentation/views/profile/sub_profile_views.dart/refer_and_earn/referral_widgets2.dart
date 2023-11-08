import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class ReferralCard2 extends StatelessWidget {
  const ReferralCard2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: EnvColors.lightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bank Payout',
            style: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 16.sp,
              color: EnvColors.darkColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Divider(
            thickness: 1.dg,
            height: 1.h,
          ).afmPadding(
            EdgeInsets.symmetric(
              vertical: 20.sp,
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'You have not setup your payout account yet. Please ',
              style: TextStyle(
                fontFamily: 'Montesserat',
                fontSize: 13.sp,
                color: EnvColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
              children: const <TextSpan>[
                TextSpan(
                  text: 'click here',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: ' to set up your bank account'),
              ],
            ),
          )
        ],
      ).afmPadding(
        EdgeInsets.all(20.sp),
      ),
    )
        .afmBorderRadius(
          BorderRadius.circular(10.r),
        )
        .afmPadding(
          EdgeInsets.only(bottom: 20.sp, left: 20.sp, right: 20.sp),
        );
  }
}
