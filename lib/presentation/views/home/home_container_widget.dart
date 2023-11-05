import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeContainer extends StatelessWidget {
  final Widget? child;
  final double height;
  final Color backgroundColor;
  const HomeContainer({
    super.key,
    this.child,
    this.height = 150,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: MediaQuery.of(context).size.width - 40.sp,
      color: backgroundColor,
      child: child,
    );
  }
}
