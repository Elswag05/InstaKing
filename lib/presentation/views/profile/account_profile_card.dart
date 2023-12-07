import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class ProfileCard extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onProfileIconTap;

  const ProfileCard({
    super.key,
    this.onTap,
    this.onProfileIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(13.sp),
        color: Theme.of(context).cardColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onProfileIconTap,
                  child: CircleAvatar(
                    radius: 25.r,
                    child: const Icon(Icons.person_add_alt_sharp),
                  ).afmPadding(EdgeInsets.only(right: 10.w)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Obasi John',
                          style: TextStyle(
                            fontFamily: 'Montesserat',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset(
                          EnvAssets.getIconPath('verified'),
                          width: 16.w,
                          height: 16.h,
                        ),
                      ],
                    ),
                    Text(
                      'Edit Personal Detail',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 14.sp,
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
            ).afmPadding(EdgeInsets.only(right: 16.h)),
          ],
        ),
      )
          .afmBorderRadius(BorderRadius.circular(10.r))
          .afmPadding(EdgeInsets.only(bottom: 20.sp)),
    );
  }
}
