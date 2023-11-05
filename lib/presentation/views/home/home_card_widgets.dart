import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/home/home_container_widget.dart';

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

class HomeCardList extends StatelessWidget {
  const HomeCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          HomeContainer(
            backgroundColor: EnvColors.mildGrey,
            child: Padding(
              padding: EdgeInsets.only(left: 18.sp, top: 3.sp, right: 18.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeCardBalance(
                        balanceString: 'Total Balance',
                        balance: 0.00,
                        toHideBalance: () {},
                      ),
                      HomeCardBalance(
                        balanceString: 'Affiliate Balance',
                        balance: 0.00,
                        toHideBalance: () {},
                      )
                    ],
                  ),
                  Container(
                    height: 25.h,
                    width: 90.w,
                    color: EnvColors.primaryColor,
                    child: Center(
                      child: Text(
                        'Fund Wallet',
                        style: TextStyle(
                          color: EnvColors.lightColor,
                          fontFamily: 'Montesserat',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                      .afmBorderRadius(BorderRadius.circular(6.r))
                      .afmPadding(EdgeInsets.only(top: 23.h)),
                ],
              ),
            ),
          )
              .afmBorderRadius(BorderRadius.circular(24.r))
              .afmPadding(EdgeInsets.only(right: 10.h)),
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width - 40.sp,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: EnvColors.containerGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 0.2, 0.5, 0.8]),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 1,
                sigmaY: 1,
              ),
              child: Container(
                color: Colors.transparent,
                height: 150.h,
                child: Center(child: Text('sn')),
              ),
            ),
          )
              .afmBorderRadius(BorderRadius.circular(24.r))
              .afmPadding(EdgeInsets.only(right: 10.h))
        ],
      ),
    ).afmPadding(EdgeInsets.only(bottom: 25.h, left: 10.sp));
  }
}
