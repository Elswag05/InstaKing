import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/profile/profile_header.dart';
import 'package:insta_king/presentation/views/profile/profile_widgets/build_profile_options.dart';

import 'build_profile_header.dart';

Widget buildProfileContent(BuildContext context, WidgetRef ref) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildProfileHeader(),
      SizedBox(height: 25.h),
      const ProfileHeader(),
      buildProfileOptions(context, ref),
    ],
  )
      .afmPadding(EdgeInsets.only(left: 20.w, right: 20.w, top: 10.sp))
      .afmNeverScroll;
}



/*



   ProfileCard(
        foregroundImageUrl: ref
                .read(instaProfileController.notifier)
                .model
                .user
                ?.profilePicture ??
            '',
        onTap: () {
          navigateToPersonalDetails(context);
        },
        onProfileIconTap: () {
          // setState(() {});
        },
      ),

 */