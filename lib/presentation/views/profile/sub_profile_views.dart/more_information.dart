import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/profile_details/personal_detail_model_structure.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

class MoreInformation extends StatelessWidget {
  const MoreInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EnvColors.appBackgroundColor,
      body: Column(
        children: [
          const RecurringAppBar(appBarTitle: "More Information")
              .afmPadding(EdgeInsets.only(bottom: 10.h)),
          Container(
            color: EnvColors.lightColor,
            child: Column(
              children: [
                const PersonalDetailModel(
                  leadTitle: "Website",
                  hintT: '',
                  isPasswordT: true,
                ),
                const PersonalDetailModel(
                  leadTitle: "Phone Number",
                  hintT: '',
                  isPasswordT: true,
                ),
                const PersonalDetailModel(
                  leadTitle: "Whatsapp Number",
                  hintT: '',
                  isPasswordT: true,
                ),
                const PersonalDetailModel(
                  leadTitle: "Address",
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
