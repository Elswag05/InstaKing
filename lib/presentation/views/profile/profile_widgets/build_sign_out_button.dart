
  import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

import '../profile_basic_functions.dart';
import '../profile_view_model.dart';

Widget buildSignOutButton(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        handleSignOut(context, ref);
      },
      child: Container(
        color: Theme.of(context).cardColor,
        child: const ProfileViewModel(modelText: 'Sign Out')
            .afmPadding(EdgeInsets.all(18.sp))
            .afmPadding(EdgeInsets.only(right: 6.sp)),
      )
          .afmBorderRadius(BorderRadius.circular(10.r))
          .afmPadding(EdgeInsets.only(top: 20.h)),
    );
  }