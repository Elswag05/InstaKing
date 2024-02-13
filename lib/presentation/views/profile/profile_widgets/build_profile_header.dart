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
      color: Colors.white,
    ),
  );
}

Widget buildProfileViewModel(String modelText, Function() onTap, String icon,
    {double sp = 20, bool isError = false, double padding = 0}) {
  return ProfileViewModel(
    icon: icon,
    modelText: modelText,
    onTap: onTap,
    iconDimension: sp,
    isError: isError,
    padding: padding,
  );
}
