// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeContainer extends StatelessWidget {
  final Widget? child;
  final double height;
  Color? color;
  HomeContainer({
    super.key,
    this.child,
    this.height = 150,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: height.h,
      width: MediaQuery.of(context).size.width - 40.sp,
      child: child,
    );
  }
}
