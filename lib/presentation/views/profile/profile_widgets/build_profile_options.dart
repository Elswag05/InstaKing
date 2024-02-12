import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/profile/profile_view_model.dart';
import 'package:insta_king/presentation/views/profile/profile_widgets/build_biomeric_switch.dart';

import '../profile_basic_functions.dart';
import 'build_profile_header.dart';

Widget buildProfileOptions(BuildContext context, WidgetRef ref) {
  return Container(
    color: Theme.of(context).cardColor,
    child: Column(
      children: [
        buildProfileViewModel(
          'Personal Information',
          () {
            navigateToPersonalDetails(context);
          },
          'user',
        ).afmPadding(),
        buildProfileViewModel(
          'Refer to Earn',
          () {
            navigateToReferAndEarn(context);
          },
          'dollar',
        ).afmPadding(),
        // buildProfileViewModel('More Information', () {
        //   navigateToMoreInformation(context);
        // }).afmPadding(),
        buildProfileViewModel(
          'Change Password',
          () {
            navigateToChangePassword(context);
          },
          'outline',
        ).afmPadding(),
        const ProfileViewModel(
          modelText: 'Support',
          icon: 'support',
        ).afmPadding(),
        // buildBiometricLockSwitch(context, ref),
        const BiometricLockSwitch(),
        buildProfileViewModel(
          'Sign Out',
          () {
            handleSignOut(context, ref);
          },
          'duotone',
        ).afmPadding(),
      ],
    ).afmPadding(EdgeInsets.all(10.sp)),
  ).afmBorderRadius(BorderRadius.circular(15.r));
}
