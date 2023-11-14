import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/wallet/add_funds/account_details.dart';

class WalletCard1 extends StatefulWidget {
  const WalletCard1({Key? key}) : super(key: key);

  @override
  State<WalletCard1> createState() => _WalletCard1State();
}

class _WalletCard1State extends State<WalletCard1> {
  late bool onGenerate;

  @override
  void initState() {
    onGenerate = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return onGenerate
        ? Container(
            color: EnvColors.lightColor,
            // width: MediaQuery.of(context).size.width - 40.sp,
            height: 480.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bank Transfer',
                  style: TextStyle(
                    fontFamily: 'Montesserat',
                    fontSize: 15.sp,
                    color: EnvColors.mildGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ).afmPadding(
                  EdgeInsets.only(
                    bottom: 20.sp,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Make transfer into the account number below to fund your wallet automatically',
                        style: TextStyle(
                          fontFamily: 'Montesserat',
                          fontSize: 15.sp,
                          color: EnvColors.mildGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Add the bank account details widgets here
                    ],
                  ),
                ),
                const AccountDetails(
                  accountName: 'John Doe',
                ),
                const AccountDetails(
                  accountName: 'John Doe',
                  bankName: 'Sterling Bank',
                ),
                const AccountDetails(
                  accountName: 'John Doe',
                  bankName: 'Moniepoint MFB',
                ),
              ],
            ).afmPadding(
              EdgeInsets.all(20.sp),
            ),
          )
            .afmBorderRadius(
              BorderRadius.circular(10.r),
            )
            .afmPadding(
              EdgeInsets.only(bottom: 20.sp, left: 20.sp, right: 20.sp),
            )
        : Container(
            color: EnvColors.lightColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bank Transfer',
                  style: TextStyle(
                    fontFamily: 'Montesserat',
                    fontSize: 15.sp,
                    color: EnvColors.mildGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ).afmPadding(
                  EdgeInsets.only(
                    bottom: 20.sp,
                  ),
                ),
                CustomButton(
                  pageCTA: 'Generate',
                  toSignOrLogin: () {
                    setState(() {
                      onGenerate = true;
                    });
                  },
                )
              ],
            ).afmPadding(
              EdgeInsets.all(20.sp),
            ),
          )
            .afmBorderRadius(
              BorderRadius.circular(10.r),
            )
            .afmPadding(
              EdgeInsets.only(bottom: 20.sp, left: 20.sp, right: 20.sp),
            );
  }
}
