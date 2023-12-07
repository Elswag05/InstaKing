import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class OrderViews extends StatelessWidget {
  const OrderViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.all(15.sp),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.star_rate_rounded,
                size: 25.sp,
              ).afmWrapUp.afmPadding(EdgeInsets.only(right: 10.w)),
              SizedBox(
                width: 150.w,
                child: Text(
                  'Instagram Service Activated',
                  softWrap: true,
                  style: TextStyle(
                    overflow: TextOverflow.clip,
                    fontFamily: 'Montesserat',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ).afmPadding(EdgeInsets.only(bottom: 10.h)),
          Text(
            'Instagram Service Activated, Thanks for staying with us.',
            style: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ).afmPadding(EdgeInsets.only(bottom: 15.w)),
          Row(
            children: [
              Icon(
                Icons.calendar_month_rounded,
                size: 10.sp,
              ).afmPadding(EdgeInsets.only(right: 5.w)),
              Text(
                '04.10.2023',
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    ).afmBorderRadius(
      BorderRadius.circular(10.r),
    );
  }
}
