import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/home/home_container_widget.dart';
import 'package:insta_king/presentation/views/shared_widgets/small_cta.dart';
import 'package:insta_king/presentation/views/wallet/insta_wallet.dart';
import 'package:intl/intl.dart';

class HomeCardBalance extends StatefulWidget {
  final String balanceString;
  final String? balance;
  final void Function()? toHideBalance;
  final Future<Object?>? future;
  final IconData hideBalanceIcon;
  const HomeCardBalance(
      {super.key,
      required this.balanceString,
      required this.balance,
      this.toHideBalance,
      this.future,
      required this.hideBalanceIcon});

  @override
  State<HomeCardBalance> createState() => _HomeCardBalanceState();
}

class _HomeCardBalanceState extends State<HomeCardBalance> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
            GestureDetector(
              onTap: widget.toHideBalance,
              child: Icon(
                widget.hideBalanceIcon,
                size: 13.sp,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ).afmPadding(
              EdgeInsets.only(
                left: 5.w,
              ),
            ),
          ],
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
        ),
      ],
    );
  }
}

String formatBalance(String balance, {bool noShowNaira = false}) {
  // Convert the balance string to a double
  final balanceValue = double.tryParse(balance);

  if (balanceValue != null) {
    // Create a NumberFormat instance with the desired formatting
    final formatter = NumberFormat.currency(
      symbol: !noShowNaira
          ? '₦'
          : '', // Set the currency symbol if needed (e.g., '$')
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
  final Function()? onTap;
  const HomeCardList({
    super.key,
    this.totalBalance = '0.00',
    this.totalBonus = '0.00',
    required this.affiliateLink,
    this.onTap,
  });

  @override
  State<HomeCardList> createState() => _HomeCardListState();
}

class _HomeCardListState extends State<HomeCardList> {
  bool hideBalance = false;
  bool hideAffiliateBalance = false;
  final String hiddenBalance = '****';
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      return SizedBox(
              height: 150.h,
              width: MediaQuery.of(context).size.width - 40.w,
              child: HomeContainer(
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
                            hideBalanceIcon: hideBalance
                                ? Icons.remove_red_eye_outlined
                                : Icons.visibility_off_outlined,
                            balance: hideBalance
                                ? hiddenBalance
                                : formatBalance(widget.totalBalance),
                            toHideBalance: () {
                              setState(() {
                                hideBalance = !hideBalance;
                              });
                            },
                          ),
                          HomeCardBalance(
                            balanceString: 'Affiliate Balance',
                            hideBalanceIcon: hideAffiliateBalance
                                ? Icons.remove_red_eye_outlined
                                : Icons.visibility_off_outlined,
                            balance: hideAffiliateBalance
                                ? hiddenBalance
                                : formatBalance(widget.totalBonus),
                            toHideBalance: () {
                              setState(() {
                                hideAffiliateBalance = !hideAffiliateBalance;
                              });
                            },
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // ref
                          //     .read(dashBoardControllerProvider.notifier)
                          //     .switchPage(3);
                          Future.delayed(Duration.zero, () async {})
                              .then((value) => {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const InstaWallet(),
                                      ),
                                    )
                                  });
                          debugPrint('Fund Wallet Button Tapped');
                        },
                        child: const SmallCTA(
                          text: 'Fund Wallet',
                        )
                            .afmBorderRadius(BorderRadius.circular(6.r))
                            .afmPadding(EdgeInsets.only(top: 23.h)),
                      ),
                    ],
                  ),
                ),
              ).afmBorderRadius(BorderRadius.circular(24.r)))
          .afmPadding(EdgeInsets.only(bottom: 15.h));
    }));
  }
}
