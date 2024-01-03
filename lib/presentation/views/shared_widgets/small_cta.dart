// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:insta_king/core/constants/env_colors.dart';

class SmallCTA extends StatefulWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final double height;
  const SmallCTA({
    super.key,
    required this.text,
    this.backgroundColor = InstaColors.primaryColor,
    this.textColor = InstaColors.lightColor,
    this.width = 90,
    this.height = 25,
  });

  @override
  State<SmallCTA> createState() => _SmallCTAState();
}

class _SmallCTAState extends State<SmallCTA> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height.h,
      width: widget.width.w,
      color: widget.backgroundColor,
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.textColor,
            fontFamily: 'Montesserat',
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
