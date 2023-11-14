import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

class BankAccountLink extends StatelessWidget {
  const BankAccountLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EnvColors.appBackgroundColor,
      body: Column(
        children: [
          const RecurringAppBar(appBarTitle: "Bank Account Details")
              .afmPadding(EdgeInsets.only(bottom: 10.h)),
          Container(
            color: EnvColors.lightColor,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bank Name',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 16.sp,
                        color: EnvColors.darkColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: EnvColors.darkColor.withOpacity(0.5),
                          width: 1.sp,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Bank',
                            style: TextStyle(
                              fontFamily: 'Montesserat',
                              fontSize: 13.sp,
                              color: EnvColors.darkColor.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                          ).afmPadding(EdgeInsets.only(left: 10.w)),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 20.sp,
                            color: EnvColors.darkColor.withOpacity(0.5),
                          ).afmPadding(EdgeInsets.only(right: 6.h)),
                        ],
                      ),
                    ).afmPadding(EdgeInsets.only(top: 10.sp, bottom: 10.sp)),
                  ],
                ),
                const CollectPersonalDetailModel(
                  leadTitle: "Account Number",
                  hintT: '',
                  isPasswordT: true,
                ),
                CustomButton(
                  pageCTA: 'Save',
                  toSignOrLogin: () {},
                ).afmPadding(EdgeInsets.symmetric(vertical: 10.h))
              ],
            ).afmPadding(
              EdgeInsets.all(
                25.sp,
              ),
            ),
          )
              .afmBorderRadius(
                BorderRadius.circular(10.r),
              )
              .afmPadding(
                EdgeInsets.symmetric(
                  horizontal: 20.sp,
                ),
              ),
        ],
      ),
    );
  }
}
