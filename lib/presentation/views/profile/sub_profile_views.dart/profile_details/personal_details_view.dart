import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/profile_details/personal_detail_model_structure.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EnvColors.appBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const RecurringAppBar(appBarTitle: "Profile Details")
              .afmPadding(EdgeInsets.only(bottom: 10.h)),
          Container(
              width: MediaQuery.of(context).size.width - 40.sp,
              color: EnvColors.lightColor,
              child: Column(
                children: [
                  const PersonalDetailModel(
                    leadTitle: "First Name",
                    hintT: 'John',
                  ),
                  const PersonalDetailModel(
                    leadTitle: "Last Name",
                    hintT: 'Doe',
                  ),
                  const PersonalDetailModel(
                    leadTitle: "E-mail",
                    hintT: 'Johndoe@gmail.com',
                  ),
                  const PersonalDetailModel(
                    leadTitle: "Time Zone",
                    hintT: '',
                  ),
                  const PersonalDetailModel(
                    leadTitle: "Password",
                    hintT: '',
                    isPasswordT: true,
                  ),
                  const PersonalDetailModel(
                    leadTitle: "Confirm Password",
                    hintT: '',
                    isPasswordT: true,
                  ),
                  CustomButton(
                    pageCTA: 'Save',
                    toSignOrLogin: () {},
                  ).afmPadding(EdgeInsets.symmetric(vertical: 10.h))
                ],
              ).afmPadding(EdgeInsets.all(
                25.sp,
              ))).afmBorderRadius(
            BorderRadius.circular(10.r),
          ),
        ],
      ).afmNeverScroll,
    );
  }
}
