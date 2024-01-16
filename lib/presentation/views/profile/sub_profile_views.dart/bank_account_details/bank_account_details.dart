import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/shared_widgets/choose_container.dart';
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
