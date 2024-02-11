
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
          buildProfileViewModel('Refer And Earn', () {
            navigateToReferAndEarn(context);
          }).afmPadding(),
          buildProfileViewModel('More Information', () {
            navigateToMoreInformation(context);
          }).afmPadding(),
          buildProfileViewModel('Change Password', () {
            navigateToChangePassword(context);
          }).afmPadding(),
          const ProfileViewModel(modelText: 'Support').afmPadding(),
          // buildBiometricLockSwitch(context, ref),
          const BiometricLockSwitch(),
        ],
      ).afmPadding(EdgeInsets.all(10.sp)),
    ).afmBorderRadius(BorderRadius.circular(10.r));
  }