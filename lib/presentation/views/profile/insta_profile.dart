import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_king/presentation/controllers/insta_login_controller.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';

import 'profile_widgets/build_profile_content.dart';

class InstaProfile extends StatefulWidget {
  const InstaProfile({super.key});

  @override
  State<InstaProfile> createState() => _InstaProfileState();
}

class _InstaProfileState extends State<InstaProfile> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          body: SafeArea(
            child: buildProfileContent(context, ref),
          ),
        );
      },
    );
  }

//  void handleBiometricSwitchChange(BuildContext context, WidgetRef ref, bool value) {
//     debugPrint("$value is valueeeee!");
//     ref.read(instaLoginController).toCheckBox(value);
//     // setState(() {
//     // });
//       value = !value;

//     if (ref.read(instaLoginController).isBoxChecked) {
//       debugPrint('User Biometric is active');
//       ref.read(instaLoginController).setUserToUSeBiometric(
//         ref.read(instaProfileController).model.user?.email ?? '',
//       );
//       // setState(() {
//       // });
//         ref.read(instaLoginController).toCheckBox(true);
//     } else {
//       debugPrint('User Biometric is NOTactive');
//       ref.read(instaLoginController).removeUserFromBiometric();
//     }
//   }
}


/*
|||Normal Stuff 
        final themeController = ref.watch(themeControllerProvider);
        bool isChangeBool = themeController.themeValue == 1 ? false : true;

|||To Support The Usage Of External Bank Accounts
                     ProfileViewModel(
                              modelText: 'Bank Account Details',
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const BankAccountLink(),
                                  ),
                                );
                              },
                            ).afmPadding(),

|||To Support The ApiKey Page
                ProfileViewModel(
                              modelText: 'Api Key',
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ApiKeyPage(),
                                  ),
                                );
                              },
                            ).afmPadding(),


||| To Support Dark Mode, But It Has Some Issues
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Dark Mode',
                                  style: TextStyle(
                                    fontFamily: 'Montesserat',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    isChangeBool = ref
                                        .read(themeControllerProvider)
                                        .setDarkTheme;
                                  },
                                  child: Switch(
                                    activeColor: InstaColors.primaryColor,
                                    activeTrackColor:
                                        InstaColors.mildLightColor,
                                    inactiveThumbColor: InstaColors.mildGrey,
                                    inactiveTrackColor:
                                        InstaColors.mildLightColor,
                                    splashRadius: 70.0,
                                    value: isChangeBool,
                                    onChanged: (value) {
                                      setState(() {
                                        value = !value;
                                        ref
                                            .read(themeControllerProvider)
                                            .toggleTheme(value);
                                        //isChangeBool = !isChangeBool;
                                      });
                                      debugPrint("$isChangeBool is valu!");
                                    },
                                  ),
                                ),
                              ],
                            ).afmPadding(
                              EdgeInsets.only(
                                left: 15.w,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Dark Mode',
                                  style: TextStyle(
                                    fontFamily: 'Montesserat',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    isChangeBool = themeController.isDarkTheme;
                                  },
                                  child: Switch(
                                    // thumb color (round icon)

                                    // boolean variable value
                                    value: isChangeBool,
                                    // changes the state of the switch
                                    onChanged: (value) {
                                      setState(() {
                                        themeController.toggleTheme();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ).afmPadding(),
 */