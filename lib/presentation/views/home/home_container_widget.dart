import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeContainer extends StatelessWidget {
  final Widget? child;
  final double height;

  const HomeContainer({
    super.key,
    this.child,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      height: height.h,
      width: MediaQuery.of(context).size.width - 40.sp,
      child: child,
    );
  }
}
