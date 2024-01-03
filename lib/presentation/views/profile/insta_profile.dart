import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/local/secure_storage_service.dart';
import 'package:insta_king/presentation/controllers/insta_categories_controller.dart';
import 'package:insta_king/presentation/controllers/insta_dashboard_controller.dart';
import 'package:insta_king/presentation/controllers/insta_login_controller.dart';
import 'package:insta_king/presentation/controllers/insta_order_controller.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/controllers/insta_transactions_controller.dart';
import 'package:insta_king/presentation/views/authentication/login/login.dart';
import 'package:insta_king/presentation/views/profile/account_profile_card.dart';
import 'package:insta_king/presentation/views/profile/profile_view_model.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/change_password.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/more_information.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/profile_details/personal_details_view.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/refer_and_earn/refer_and_earn.dart';
import 'package:insta_king/utils/locator.dart';

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
      builder: ((context, ref, child) {
        //final themeController = ref.watch(themeControllerProvider);
        //bool isChangeBool = themeController.isDarkTheme;

        void toDispose() {
          ref.read(instaTransactionController).disposeTrx();
          ref.read(instaCategoriesController).disposeCategries();
          ref.read(instaProfileController).disposeProf();
          ref.read(instaOrderController).disposeOrders();
          super.dispose();
        }

        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Account',
                  style: TextStyle(
                    fontFamily: 'Montesserat',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                ProfileCard(
                  foregroundImageUrl: ref
                          .read(instaProfileController.notifier)
                          .model
                          .user
                          ?.profilePicture ??
                      '',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PersonalDetails(),
                      ),
                    );
                  },
                  onProfileIconTap: () {
                    // setState(() {});
                  },
                ),
                Container(
                        color: Theme.of(context).cardColor,
                        child: Column(
                          children: [
                            // ProfileViewModel(
                            //   modelText: 'Bank Account Details',
                            //   onTap: () {
                            //     Navigator.of(context).push(
                            //       MaterialPageRoute(
                            //         builder: (context) =>
                            //             const BankAccountLink(),
                            //       ),
                            //     );
                            //   },
                            // ).afmPadding(),
                            ProfileViewModel(
                              modelText: 'Refer And Earn',
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ReferAndEarn(),
                                  ),
                                );
                              },
                            ).afmPadding(),
                            ProfileViewModel(
                              modelText: 'More Information',
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MoreInformation(),
                                  ),
                                );
                              },
                            ).afmPadding(),
                            // ProfileViewModel(
                            //   modelText: 'Api Key',
                            //   onTap: () {
                            //     Navigator.of(context).push(
                            //       MaterialPageRoute(
                            //         builder: (context) => const ApiKeyPage(),
                            //       ),
                            //     );
                            //   },
                            // ).afmPadding(),
                            ProfileViewModel(
                              modelText: 'Change Password',
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangePassword(),
                                  ),
                                );
                              },
                            ).afmPadding(),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       'Dark Mode',
                            //       style: TextStyle(
                            //         fontFamily: 'Montesserat',
                            //         fontSize: 14.sp,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //     GestureDetector(
                            //       onTap: () {
                            //         isChangeBool = themeController.isDarkTheme;
                            //       },
                            //       child: Switch(
                            //         // thumb color (round icon)
                            //         activeColor: InstaColors.primaryColor,
                            //         activeTrackColor:
                            //             InstaColors.mildLightColor,
                            //         inactiveThumbColor: InstaColors.mildGrey,
                            //         inactiveTrackColor:
                            //             InstaColors.mildLightColor,
                            //         splashRadius: 70.0,
                            //         // boolean variable value
                            //         value: isChangeBool,
                            //         // changes the state of the switch
                            //         onChanged: (value) {
                            //           setState(() {
                            //             themeController.toggleTheme();
                            //           });
                            //         },
                            //       ),
                            //     ),
                            //   ],
                            // ).afmPadding(),
                            const ProfileViewModel(modelText: 'Support')
                                .afmPadding(),
                          ],
                        ).afmPadding(EdgeInsets.all(10.sp)))
                    .afmBorderRadius(BorderRadius.circular(10.r)),
                GestureDetector(
                  onTap: () {
                    ref.read(instaLoginController.notifier).signOut().then(
                      (value) {
                        if (value == true) {
                          ref
                              .read(dashBoardControllerProvider.notifier)
                              .setPage(0);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const InstaLogin(),
                            ),
                          );
                          locator<SecureStorageService>().delete(key: 'token');
                          locator<SecureStorageService>().delete(key: 'email');
                          toDispose();
                        } else {}
                      },
                    );
                  },
                  child: Container(
                    color: Theme.of(context).cardColor,
                    child: const ProfileViewModel(modelText: 'Sign Out')
                        .afmPadding(EdgeInsets.all(18.sp))
                        .afmPadding(EdgeInsets.only(right: 6.sp)),
                  )
                      .afmBorderRadius(BorderRadius.circular(10.r))
                      .afmPadding(EdgeInsets.only(top: 20.h)),
                ),
              ],
            )
                .afmPadding(
                    EdgeInsets.only(left: 20.w, right: 20.w, top: 10.sp))
                .afmNeverScroll,
          ),
        );
      }),
    );
  }
}
