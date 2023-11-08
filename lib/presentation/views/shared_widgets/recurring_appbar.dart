import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class RecurringAppBar extends StatelessWidget {
  final String appBarTitle;
  const RecurringAppBar({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          IconButton(
            splashColor: EnvColors.mildGrey,
            splashRadius: 20.r,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: 'return to previous page',
            highlightColor: EnvColors.primaryColor,
            color: EnvColors.mildGrey,
          ),
          Text(
            appBarTitle,
            style: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 20.sp,
              color: EnvColors.darkColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ).afmPadding(EdgeInsets.only(left: 10.w)),
    );
  }
}
