import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/refer_and_earn/refer_and_earn.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/refer_and_earn/referral_widgets1.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/refer_and_earn/referral_widgets2.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/refer_and_earn/referral_widgets3.dart';
import 'package:insta_king/presentation/views/wallet/recent_deposits.dart';
import 'package:insta_king/presentation/views/wallet/select_payment_options.dart';
import 'package:insta_king/presentation/views/wallet/wallet_appbar.dart';
import 'package:insta_king/presentation/views/wallet/generate_bank_transfer.dart';

class InstaWallet extends StatelessWidget {
  const InstaWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const WalletAppBar()
                .afmPadding(
                  EdgeInsets.only(left: 20.sp, right: 20.sp),
                )
                .afmPadding(EdgeInsets.only(bottom: 10.h)),
            // const ReferralCopyCard(),
            const WalletCard1(),
            const SelectPaymentOptions(),
            const RecentDeposits(),
          ],
        ).afmNeverScroll,
      ),
    );
  }
}
