import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class ReferralCard3 extends StatelessWidget {
  const ReferralCard3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: EnvColors.lightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bank Payout History',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'No',
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 10.sp,
                  color: EnvColors.darkColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Amount',
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 10.sp,
                  color: EnvColors.darkColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Bank \nName',
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 10.sp,
                  color: EnvColors.darkColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Account \nName',
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 10.sp,
                  color: EnvColors.darkColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Account \nNumber',
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 10.sp,
                  color: EnvColors.darkColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Status',
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 10.sp,
                  color: EnvColors.darkColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
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
