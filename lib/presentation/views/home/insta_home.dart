import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';

class InstaHome extends StatelessWidget {
  const InstaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: EnvColors.appBackgroundColor,
        body: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.person_add_alt_sharp),
                    radius: 25.r,
                  ),
                  Column(
                    children: [
                      Text(
                        'Hi, John',
                      ),
                      Text(
                        'Welcome Back',
                      ),
                    ],
                  ),
                  Container(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
