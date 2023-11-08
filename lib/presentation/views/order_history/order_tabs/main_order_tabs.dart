import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class OrderChips extends StatelessWidget {
  final bool isSelected;
  final void Function(bool)? onSelected;
  final String label;
  const OrderChips(
      {super.key,
      required this.isSelected,
      this.onSelected,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: isSelected,
      onSelected: onSelected,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(8.sp),
      backgroundColor: EnvColors.mildGrey,
      label: Text(
        label,
        style: TextStyle(
          fontSize: 15.sp,
          color: EnvColors.lightColor,
        ),
      ), //Text
    ).afmPadding(EdgeInsets.only(right: 10.w));
  }
}
