import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13.sp),
      color: EnvColors.lightColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                child: const Icon(Icons.person_add_alt_sharp),
              ).afmPadding(EdgeInsets.only(right: 10.w)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John',
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      fontSize: 14.sp,
                      color: EnvColors.darkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Edit Personal Detail',
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      fontSize: 14.sp,
                      color: EnvColors.darkColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20.sp,
            color: EnvColors.mildGrey,
          ).afmPadding(EdgeInsets.only(right: 16.h)),
        ],
      ),
    )
        .afmBorderRadius(BorderRadius.circular(10.r))
        .afmPadding(EdgeInsets.only(bottom: 20.sp));
  }
}
