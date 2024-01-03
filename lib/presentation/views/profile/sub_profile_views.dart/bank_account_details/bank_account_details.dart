import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

class BankAccountLink extends StatelessWidget {
  const BankAccountLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const RecurringAppBar(appBarTitle: "Bank Account Details")
              .afmPadding(EdgeInsets.only(bottom: 10.h)),
          Container(
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                const ChooseContainerFromDropDown(
                  headerText: 'Bank Name',
                  hintText: 'Loading...',
                ),
                const CollectPersonalDetailModel(
                  leadTitle: "Account Number",
                  hintT: '',
                  isPasswordT: false,
                ),
                CustomButton(
                  pageCTA: 'Save',
                  buttonOnPressed: () {},
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
              )
        ],
      ),
    );
  }
}

class ChooseContainerFromDropDown extends StatelessWidget {
  final String headerText;
  final String hintText;
  final IconData displayIcon;
  const ChooseContainerFromDropDown(
      {super.key,
      required this.headerText,
      required this.hintText,
      this.displayIcon = Icons.keyboard_arrow_down_rounded});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: TextStyle(
            fontFamily: 'Montesserat',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.sp,
              color: Theme.of(context).unselectedWidgetColor,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                hintText,
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ).afmPadding(EdgeInsets.only(left: 10.w)),
              Icon(
                displayIcon,
                size: 20.sp,
              ).afmPadding(EdgeInsets.only(right: 6.h)),
            ],
          ),
        ).afmPadding(EdgeInsets.only(top: 10.sp, bottom: 10.sp)),
      ],
    );
  }
}
