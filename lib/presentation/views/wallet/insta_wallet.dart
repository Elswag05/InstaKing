import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/wallet/wallet_appbar.dart';
import 'package:insta_king/presentation/views/wallet/generate_bank_transfer.dart';

class InstaWallet extends StatelessWidget {
  const InstaWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const WalletAppBar().afmPadding(
              EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 20.h),
            ),
            const WalletCard1(),
          ],
        ).afmNeverScroll,
      ),
    );
  }
}

            //const ReferralCopyCard(),
            //const SelectPaymentOptions(),
            //const RecentDeposits(),