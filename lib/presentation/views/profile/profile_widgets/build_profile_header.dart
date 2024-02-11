    import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/presentation/views/profile/profile_view_model.dart';

Widget buildProfileHeader() {
    return Text(
      'Profile',
      style: TextStyle(
        fontFamily: 'Montesserat',
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }


  Widget buildProfileViewModel(String modelText, Function() onTap) {
    return ProfileViewModel(
      modelText: modelText,
      onTap: onTap,
    );
  }