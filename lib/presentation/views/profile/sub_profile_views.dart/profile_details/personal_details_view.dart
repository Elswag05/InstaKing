import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';

class PersonalDetails extends ConsumerStatefulWidget {
  const PersonalDetails({super.key});

  @override
  ConsumerState<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends ConsumerState<PersonalDetails> {
  late final TextEditingController firstName;
  late final TextEditingController lastName;
  late final TextEditingController address;
  late final TextEditingController phone;
  late final TextEditingController country;

  @override
  void initState() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    address = TextEditingController();
    phone = TextEditingController();
    country = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    address.dispose();
    phone.dispose();
    country.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoadingState loadingState =
        ref.watch(instaProfileController).loadingState;
    return Scaffold(
      body: Consumer(
        builder: ((context, ref, child) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const RecurringAppBar(appBarTitle: "Profile Details")
                      .afmPadding(EdgeInsets.only(bottom: 10.h)),
                  Container(
                      width: MediaQuery.of(context).size.width - 40.sp,
                      color: Theme.of(context).cardColor,
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
                            buttonOnPressed: () {
                              ref
                                  .read(instaProfileController.notifier)
                                  .editPersonalDetails(
                                    firstName.text,
                                    lastName.text,
                                    address.text,
                                    phone.text,
                                    country.text,
                                  )
                                  .then((value) {
                                if (value == true) {
                                  //Handle success
                                  ref
                                      .read(instaProfileController.notifier)
                                      .getProfileDetails();
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.scale,
                                    dialogType: DialogType.success,
                                    title: 'Edit Successful',
                                    desc:
                                        'Your profile information has been saved',
                                    btnOkOnPress: () {
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                  ).show();
                                } else {
                                  setState(() {});
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.scale,
                                    dialogType: DialogType.error,
                                    title: 'Edit Failed',
                                    desc:
                                        'Your profile information could not be saved, please try again later!',
                                    btnOkOnPress: () {
                                      Navigator.pop(context);
                                    },
                                  ).show();
                                }
                              });
                            },
                          ).afmPadding(EdgeInsets.symmetric(vertical: 10.h))
                        ],
                      ).afmPadding(EdgeInsets.all(
                        25.sp,
                      ))).afmBorderRadius(
                    BorderRadius.circular(10.r),
                  ),
                ],
              ).afmNeverScroll,
              if (loadingState == LoadingState.loading)
                const TransparentLoadingScreen(),
            ],
          );
        }),
      ),
    );
  }
}
