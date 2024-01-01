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
          width: 0.5,
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
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    bankName,
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      fontSize: 14.sp,
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
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    accountName,
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account Number',
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    accountNumber,
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ), //.afmPadding(EdgeInsets.only(left: 40.w)),
                  const SizedBox(),
                  Positioned(
                    right: 40,
                    top: 10,
                    child: GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: accountNumber),
                        ).then(
                          (value) {
                            debugPrint(
                                'data copied successfully $accountNumber');
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
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.copy,
                            size: 16.sp,
                            color:
                                Theme.of(context).colorScheme.onInverseSurface,
                          ),
                        ),
                      ).afmPadding(EdgeInsets.only(left: 4.sp)),
                    ),
                  ),
                ],
              )
            ],
          ).afmPadding(EdgeInsets.only(top: 18.sp)),
        ],
      ),
    ).afmPadding(
      EdgeInsets.symmetric(vertical: 5.sp),
    );
  }
}
