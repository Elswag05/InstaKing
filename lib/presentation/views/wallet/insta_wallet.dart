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
              EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
            ),
            const WalletCard1(),
          ],
        ).afmNeverScroll,
      ),
    );
  }
}
