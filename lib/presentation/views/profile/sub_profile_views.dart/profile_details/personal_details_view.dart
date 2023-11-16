import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstName = TextEditingController();
    final TextEditingController lastName = TextEditingController();
    final TextEditingController address = TextEditingController();
    final TextEditingController phone = TextEditingController();
    final TextEditingController country = TextEditingController();
    return Scaffold(
      backgroundColor: EnvColors.appBackgroundColor,
      body: Consumer(builder: ((context, ref, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const RecurringAppBar(appBarTitle: "Profile Details")
                .afmPadding(EdgeInsets.only(bottom: 10.h)),
            Container(
                width: MediaQuery.of(context).size.width - 40.sp,
                color: EnvColors.lightColor,
                child: Column(
                  children: [
                    CollectPersonalDetailModel(
                      leadTitle: "First Name",
                      hintT: 'John',
                      controller: firstName,
                    ),
                    CollectPersonalDetailModel(
                      leadTitle: "Last Name",
                      hintT: 'Doe',
                      controller: lastName,
                    ),
                    CollectPersonalDetailModel(
                      leadTitle: "Address",
                      hintT: 'Lagos Ibadan Express',
                      controller: address,
                    ),
                    CollectPersonalDetailModel(
                      leadTitle: "Phone",
                      hintT: '090 XXX XXXX',
                      controller: phone,
                    ),
                    CollectPersonalDetailModel(
                      leadTitle: "Country",
                      hintT: 'United Kingdom',
                      controller: country,
                    ),
                    CustomButton(
                      pageCTA: 'Save',
                      toSignOrLogin: () {
                        ref
                            .read(instaProfileController.notifier)
                            .editPersonalDetails(firstName.text, lastName.text,
                                address.text, phone.text, country.text)
                            .then(
                              (value) => Navigator.pop(context),
                            );
                      },
                    ).afmPadding(EdgeInsets.symmetric(vertical: 10.h))
                  ],
                ).afmPadding(EdgeInsets.all(
                  25.sp,
                ))).afmBorderRadius(
              BorderRadius.circular(10.r),
            ),
          ],
        ).afmNeverScroll;
      })),
    );
  }
}
