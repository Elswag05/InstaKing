import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

class MoreInformation extends StatelessWidget {
  const MoreInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const RecurringAppBar(appBarTitle: "More Information")
              .afmPadding(EdgeInsets.only(bottom: 10.h)),
          Container(
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                const CollectPersonalDetailModel(
                  leadTitle: "Website",
                  hintT: '',
                  isPasswordT: false,
                ),
                const CollectPersonalDetailModel(
                  leadTitle: "Phone Number",
                  hintT: '',
                  isPasswordT: false,
                ),
                CollectPersonalDetailModel(
                  leadTitle: "Whatsapp Number",
                  hintT: '',
                  isdigit: [FilteringTextInputFormatter.digitsOnly],
                  isPasswordT: false,
                ),
                const CollectPersonalDetailModel(
                  leadTitle: "Address",
                  hintT: '',
                  isPasswordT: false,
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
      ).afmNeverScroll,
    );
  }
}
