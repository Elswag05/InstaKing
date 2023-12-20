import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

Column noticeBoard(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          color: InstaColors.lightColor,
          border: Border.all(
            width: 0.5,
            color: Theme.of(context).colorScheme.surface,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notice: ',
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: InstaColors.darkColor,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                '1. Please make sure your page is not Private.',
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                '2. Kindly refrain from placing a second order on the same link until your initial order is completed.',
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                '3. Please be note that there may be speed changes in service delivery during periods of high demand.',
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Container announcements(BuildContext context) {
  return Container(
    color: Theme.of(context).cardColor,
    padding: EdgeInsets.all(15.sp),
    child: Column(
      children: [
        Row(
          children: [
            ImageIcon(
              AssetImage(
                EnvAssets.getIconPath('bell'),
              ),
              size: 25.sp,
            ).afmWrapUp.afmPadding(EdgeInsets.only(right: 10.w)),
            Text(
              'Announcements',
              style: TextStyle(
                fontFamily: 'Montesserat',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ).afmPadding(EdgeInsets.only(
          bottom: 10.h,
        )),
        // const OrderViews(),
      ],
    ),
  );
}
