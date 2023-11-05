import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/profile/account_profile_card.dart';
import 'package:insta_king/presentation/views/profile/profile_view_model.dart';

class InstaProfile extends StatelessWidget {
  const InstaProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: EnvColors.appBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Account',
              style: TextStyle(
                fontFamily: 'Montesserat',
                fontSize: 20.sp,
                color: EnvColors.darkColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            const ProfileCard(),
            Container(
                    color: EnvColors.lightColor,
                    child: Column(
                      children: [
                        const ProfileViewModel(
                                modelText: 'Bank Account Details')
                            .afmPadding(),
                        const ProfileViewModel(modelText: 'Refer And Earn')
                            .afmPadding(),
                        const ProfileViewModel(modelText: 'More Information')
                            .afmPadding(),
                        const ProfileViewModel(modelText: 'Api Key')
                            .afmPadding(),
                        const ProfileViewModel(modelText: 'Dark Mode')
                            .afmPadding(),
                        const ProfileViewModel(modelText: 'Support')
                            .afmPadding(),
                      ],
                    ).afmPadding(EdgeInsets.all(10.sp)))
                .afmBorderRadius(BorderRadius.circular(10.r)),
            Container(
              color: EnvColors.lightColor,
              child: const ProfileViewModel(modelText: 'Sign Out')
                  .afmPadding(EdgeInsets.all(18.sp)),
            )
                .afmBorderRadius(BorderRadius.circular(10.r))
                .afmPadding(EdgeInsets.only(top: 20.h)),
          ],
        ).afmPadding(EdgeInsets.only(left: 20.w, right: 20.w)),
      ),
    );
  }
}