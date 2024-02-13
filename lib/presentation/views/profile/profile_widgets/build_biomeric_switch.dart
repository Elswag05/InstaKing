import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_login_controller.dart';

import '../../../controllers/insta_profile_controller.dart';

// Widget buildBiometricLockSwitch(BuildContext context, WidgetRef ref) {
//     return
//   }

class BiometricLockSwitch extends StatefulWidget {
  const BiometricLockSwitch({super.key});

  @override
  State<BiometricLockSwitch> createState() => _BiometricLockSwitchState();
}

class _BiometricLockSwitchState extends State<BiometricLockSwitch> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return SizedBox(
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  EnvAssets.getSvgPath('fingerprint'),
                  width: 23.w,
                  height: 23.h,
                ).afmPadding(
                  EdgeInsets.only(right: 10.h),
                ),
                Text(
                  'Login with Biometrics',
                  style: TextStyle(
                    fontFamily: 'Montesserat',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            GestureDetector(
              child: Switch(
                activeColor: InstaColors.primaryColor,
                activeTrackColor: InstaColors.mildLightColor,
                inactiveThumbColor: InstaColors.mildGrey,
                inactiveTrackColor: InstaColors.mildLightColor,
                splashRadius: 70.0,
                value: ref.read(instaLoginController).isBoxChecked,
                onChanged: (value) {
                  // handleBiometricSwitchChange(context, ref, value);
                  debugPrint("$value is valueeeee!");
                  ref.read(instaLoginController).toCheckBox(value);
                  setState(() {
                    value = !value;
                  });

                  if (ref.read(instaLoginController).isBoxChecked) {
                    debugPrint('User Biometric is active');
                    ref.read(instaLoginController).setUserToUSeBiometric(
                          ref.read(instaProfileController).model.user?.email ??
                              '',
                        );
                    setState(() {
                      ref.read(instaLoginController).toCheckBox(true);
                    });
                  } else {
                    debugPrint('User Biometric is NOTactive');
                    ref.read(instaLoginController).removeUserFromBiometric();
                  }
                },
              ),
            ),
          ],
        ).afmPadding(EdgeInsets.only(left: 15.w)),
      );
    });
  }
}
