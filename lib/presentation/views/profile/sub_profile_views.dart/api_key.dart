import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

class ApiKeyPage extends StatelessWidget {
  const ApiKeyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EnvColors.appBackgroundColor,
      body: Column(
        children: [
          const RecurringAppBar(appBarTitle: "API keys")
              .afmPadding(EdgeInsets.only(bottom: 10.h)),
          Container(
            color: EnvColors.lightColor,
            child: Column(
              children: [
                const CollectPersonalDetailModel(
                  leadTitle: "Key",
                  hintT: 'WjC1G19h2hgsdyyd86386hcysdajh',
                  isPasswordT: true,
                ),
                CustomButton(
                  pageCTA: 'Generate New',
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
