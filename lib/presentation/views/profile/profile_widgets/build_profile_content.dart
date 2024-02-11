import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/views/profile/account_profile_card.dart';
import 'package:insta_king/presentation/views/profile/profile_basic_functions.dart';
import 'package:insta_king/presentation/views/profile/profile_widgets/build_profile_options.dart';
import 'package:insta_king/presentation/views/profile/profile_widgets/build_sign_out_button.dart';

import 'build_profile_header.dart';
 
  Widget buildProfileContent(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildProfileHeader(),
        SizedBox(height: 30.h),
        ProfileCard(
          foregroundImageUrl:
              ref.read(instaProfileController.notifier).model.user?.profilePicture ?? '',
          onTap: () {
            navigateToPersonalDetails(context);
          },
          onProfileIconTap: () {
            // setState(() {});
          },
        ),
        buildProfileOptions(context, ref),
        buildSignOutButton(context, ref),
      ],
    )
        .afmPadding(EdgeInsets.only(left: 20.w, right: 20.w, top: 10.sp))
        .afmNeverScroll;
  }


