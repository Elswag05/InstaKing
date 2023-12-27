import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/presentation/views/services/service_widgets.dart';

class ServiceWidgetModel extends StatelessWidget {
  final String idtext;
  final String min;
  final String max;
  final String name;
  final String price;

  const ServiceWidgetModel({
    super.key,
    required this.idtext,
    required this.min,
    required this.max,
    required this.price,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        lightText('ID', context),
        Positioned(
          left: MediaQuery.of(context).size.width / 2.5.w,
          child: darkText(idtext, context),
        ),
        Positioned(
          top: 20.h,
          child: lightText('NAME', context),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2.5.w,
          top: 20.h,
          child: SizedBox(
            height: 47.h,
            width: 150,
            child: darkText(name, context),
          ),
        ),
        Positioned(
          top: 75.h,
          child: lightText('PRICE PER 1000', context),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2.5.w,
          top: 75.h,
          child: SizedBox(
            height: 20.h,
            width: 80.w,
            child: darkText('₦$price', context),
          ),
        ),
        Positioned(
          top: 95.h,
          child: lightText('MIN - MAX', context),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2.5.w,
          top: 95.h,
          child: darkText('$min - $max', context),
        ),
      ],
    );
  }
}
