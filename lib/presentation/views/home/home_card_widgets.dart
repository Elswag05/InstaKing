import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/core/theme/env_theme_manager.dart';
import 'package:insta_king/presentation/views/home/home_container_widget.dart';
import 'package:insta_king/presentation/views/shared_widgets/small_cta.dart';
import 'package:intl/intl.dart';

class HomeCardBalance extends StatefulWidget {
  final String balanceString;
  final String? balance;
  final void Function()? toHideBalance;
  final Future<Object?>? future;
  const HomeCardBalance(
      {super.key,
      required this.balanceString,
      required this.balance,
      this.toHideBalance,
      this.future});

  @override
  State<HomeCardBalance> createState() => _HomeCardBalanceState();
}

class _HomeCardBalanceState extends State<HomeCardBalance> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.balanceString,
          style: TextStyle(
            fontFamily: 'Montesserat',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          '${widget.balance}',
          style: TextStyle(
            fontFamily: 'Montesserat',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ).afmGetFuture(widget.future),
      ],
    );
  }
}

String formatBalance(String balance) {
  // Convert the balance string to a double
  final balanceValue = double.tryParse(balance);

  if (balanceValue != null) {
    // Create a NumberFormat instance with the desired formatting
    final formatter = NumberFormat.currency(
      symbol: '₦', // Set the currency symbol if needed (e.g., '$')
      decimalDigits: 2, // Set the number of decimal places
    );

    // Format the balance value
    final formattedBalance = formatter.format(balanceValue);

    return formattedBalance;
  }

  // Return the original balance string if it couldn't be parsed as a double
  return balance;
}

class HomeCardList extends StatefulWidget {
  final String totalBalance;
  final String totalBonus;
  final String affiliateLink;
  final Future<Object?>? future;
  const HomeCardList({
    super.key,
    this.totalBalance = '0.00',
    this.totalBonus = '0.00',
    required this.affiliateLink,
    this.future,
  });

  @override
  State<HomeCardList> createState() => _HomeCardListState();
}

class _HomeCardListState extends State<HomeCardList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      width: MediaQuery.of(context).size.width - 40.w,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          HomeContainer(
            color: InstaColors.mildGrey,
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
                        balance: formatBalance(widget.totalBalance),
                        toHideBalance: () {},
                        future: widget.future,
                      ),
                      HomeCardBalance(
                        balanceString: 'Affiliate Balance',
                        balance: formatBalance(widget.totalBonus),
                        toHideBalance: () {},
                        future: widget.future,
                      )
                    ],
                  ),
                  const SmallCTA(
                    text: 'Fund Wallet',
                  )
                      .afmBorderRadius(BorderRadius.circular(6.r))
                      .afmPadding(EdgeInsets.only(top: 23.h)),
                ],
              ),
            ),
          )
              .afmBorderRadius(BorderRadius.circular(24.r))
              .afmPadding(EdgeInsets.only(right: 10.h)),
          // Container(
          //   height: 150,
          //   width: MediaQuery.of(context).size.width - 40.sp,
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         colors: InstaColors.containerGradient,
          //         begin: Alignment.topLeft,
          //         end: Alignment.bottomRight,
          //         stops: const [0, 0.2, 0.5, 0.8]),
          //   ),
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(
          //       sigmaX: 1,
          //       sigmaY: 1,
          //     ),
          //     child: Center(
          //       child: Container(
          //         color: Colors.transparent,
          //         height: 150.h,
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             Text(
          //               'Refer & Earn',
          //               style: TextStyle(
          //                 fontFamily: 'Montesserat',
          //                 fontSize: 16.sp,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //             Text(
          //               'Invite your friends and earn a commission for all their transactions on InstaKing.',
          //               style: TextStyle(
          //                 fontFamily: 'Montesserat',
          //                 fontSize: 14.sp,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //             Stack(
          //               children: [
          //                 Container(
          //                   width: double.infinity - 20.w,
          //                   height: 30.h,
          //                   decoration: BoxDecoration(
          //                     color: Theme.of(context).splashColor,
          //                     borderRadius: BorderRadius.circular(15.r),
          //                   ),
          //                 ),
          //                 Container(
          //                   width: 240.w,
          //                   height: 30.h,
          //                   decoration: BoxDecoration(
          //                     color: Theme.of(context).canvasColor,
          //                   ),
          //                   child: Center(
          //                     child: Text(
          //                       widget.affiliateLink,
          //                       overflow: TextOverflow.ellipsis,
          //                       style: TextStyle(
          //                         fontSize: 15.sp,
          //                         fontWeight: FontWeight.w400,
          //                       ),
          //                     ).afmPadding(EdgeInsets.only(left: 5.w)),
          //                   ),
          //                 ).afmBorderRadius(BorderRadius.only(
          //                     bottomLeft: Radius.circular(15.r),
          //                     topLeft: Radius.circular(15.r))),
          //                 Positioned(
          //                   top: 7.h,
          //                   right: 13.w,
          //                   child: GestureDetector(
          //                     onTap: () {
          //                       Clipboard.setData(
          //                         ClipboardData(text: widget.affiliateLink),
          //                       ).then(
          //                         (value) {
          //                           debugPrint(
          //                               'data copied successfully ${widget.affiliateLink}');
          //                           locator<ToastService>().showSuccessToast(
          //                             'You have copied you referral link',
          //                           );
          //                         },
          //                       );
          //                     },
          //                     child: Icon(
          //                       Icons.content_copy_outlined,
          //                       size: 20.sp,
          //                       color: InstaColors.lightColor,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ).afmPadding(EdgeInsets.all(20.sp)),
          //       ),
          //     ),
          //   ),
          // )
          //     .afmBorderRadius(BorderRadius.circular(24.r))
          //     .afmPadding(EdgeInsets.only(right: 10.h))
        ],
      ),
    ).afmPadding(EdgeInsets.only(bottom: 25.h, left: 10.sp));
  }
}
