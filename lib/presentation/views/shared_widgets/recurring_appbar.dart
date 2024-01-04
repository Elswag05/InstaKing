import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class RecurringAppBar extends StatelessWidget {
  final String appBarTitle;
  final bool hasLeading;
  const RecurringAppBar(
      {super.key, required this.appBarTitle, this.hasLeading = true});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          hasLeading
              ? IconButton(
                  splashRadius: 20.r,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip: 'return to previous page',
                  highlightColor: InstaColors.primaryColor,
                )
              : SizedBox(
                  width: 20.r,
                ),
          Text(
            appBarTitle,
            style: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ).afmPadding(EdgeInsets.only(left: 10.w)),
    );
  }
}
