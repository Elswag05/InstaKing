import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';

class HomeCardBalance extends StatelessWidget {
  final String balanceString;
  final double balance;
  final void Function()? toHideBalance;
  const HomeCardBalance(
      {super.key,
      required this.balanceString,
      required this.balance,
      this.toHideBalance});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          balanceString,
          style: TextStyle(
            color: EnvColors.lightColor,
            fontFamily: 'Montesserat',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          '#$balance',
          style: TextStyle(
            color: EnvColors.lightColor,
            fontFamily: 'Montesserat',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
