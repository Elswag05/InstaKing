import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/refer_and_earn/referral_widgets1.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/refer_and_earn/referral_widgets2.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/refer_and_earn/referral_widgets3.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

class ReferAndEarn extends StatelessWidget {
  const ReferAndEarn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const RecurringAppBar(appBarTitle: "Refer And Earn")
              .afmPadding(EdgeInsets.only(bottom: 10.h)),
          const ReferralCopyCard(),
          const ReferralCard2(),
          const ReferralCard3(),
        ],
      ).afmNeverScroll,
    );
  }
}
