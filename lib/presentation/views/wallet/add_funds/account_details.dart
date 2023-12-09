import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/utils/locator.dart';

class AccountDetails extends StatelessWidget {
  final String accountName;
  final String bankName;
  final String accountNumber;
  const AccountDetails(
      {super.key,
      this.accountName = 'InstaKing-Ayo',
      this.bankName = 'Wema Bank',
      this.accountNumber = '9207669559'});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Theme.of(context).unselectedWidgetColor,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(10.sp),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bank Name',
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    bankName,
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Account Name',
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    accountName,
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border.all(
                    color: InstaColors.darkColor.withOpacity(0.5),
                    width: 1.sp,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      accountNumber,
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3.w,
                      ),
                    ).afmPadding(EdgeInsets.only(left: 40.w)),
                    const SizedBox(),
                  ],
                ),
              ).afmPadding(EdgeInsets.only(top: 10.sp, bottom: 10.sp)),
              Positioned(
                right: 40,
                top: 10,
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(text: accountNumber),
                    ).then(
                      (value) {
                        debugPrint('data copied successfully $accountNumber');
                        locator<ToastService>().showSuccessToast(
                          'You have the account number to your clip board',
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 25.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                      color: InstaColors.primaryColor,
                      // border: Border.all(
                      //   color: InstaColors.darkColor.withOpacity(0.5),
                      //   width: 1.sp,
                      // ),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.copy,
                        size: 16.sp,
                        color: Theme.of(context).colorScheme.onInverseSurface,
                      ),

                      // Text(
                      //   'Copy',
                      //   style: TextStyle(
                      //     fontFamily: 'Montesserat',
                      //     fontSize: 15.sp,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ).afmPadding(EdgeInsets.only(right: 10.w, bottom: 3.h)),
                    ),
                  ).afmPadding(EdgeInsets.only(top: 10.sp, bottom: 10.sp)),
                ),
              ),
            ],
          )
        ],
      ),
    ).afmPadding(
      EdgeInsets.symmetric(vertical: 5.sp),
    );
  }
}
