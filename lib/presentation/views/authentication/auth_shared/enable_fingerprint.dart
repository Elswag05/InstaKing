import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_assets.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/controllers/insta_login_controller.dart';
import 'package:insta_king/data/controllers/insta_signin_controller.dart';
import 'package:insta_king/presentation/views/dashboard/insta_dashboard.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';

class PostSignUp extends StatefulWidget {
  const PostSignUp({super.key});

  @override
  State<PostSignUp> createState() => _PostSignUpState();
}

class _PostSignUpState extends State<PostSignUp> with TickerProviderStateMixin {
  int animationCount = 0;
  bool isPlaying = false;
  final controller = ConfettiController();

  @override
  void initState() {
    controller.play();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Image.asset(
                  EnvAssets.getImagePath('congratulations'),
                  width: 400.w,
                  height: 400.h,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: controller,
                    shouldLoop: true,
                    blastDirection: pi / 2,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Registration Successful',
                    style: TextStyle(
                      fontFamily: 'Monteserrat',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ).afmPadding(
                    EdgeInsets.only(bottom: 20.h),
                  ),
                ),
              ],
            ).afmPadding(
              EdgeInsets.only(top: 40.h),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              children: [
                RichText(
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  softWrap: true,
                  maxLines: 3,
                  textScaler: TextScaler.noScaling,
                  text: TextSpan(
                    text:
                        'To ensure easier access next time, would you\n like to ',
                    style: TextStyle(
                      fontFamily: 'Monteserrat',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Enable biometric authentication',
                        style: TextStyle(
                          fontFamily: 'Monteserrat',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return Column(
                      children: [
                        CustomButton(
                          pageCTA: 'Yes ',
                          color: InstaColors.primaryColor,
                          buttonTextColor: InstaColors.darkColor,
                          buttonOnPressed: () {
                            setState(() {
                              ref.read(instaLoginController)
                                ..toCheckBox(true)
                                ..doRememberMe(
                                  ref
                                          .read(instaSignUpController)
                                          .data
                                          .user
                                          ?.email ??
                                      '',
                                )
                                ..writeLoggedIn();

                              debugPrint('user has decided to remember me');
                            });
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InstaDashboard(),
                              ),
                            );
                          },
                        )
                            .afmBorderRadius(
                              BorderRadius.circular(
                                50.r,
                              ),
                            )
                            .afmPadding(
                              EdgeInsets.only(bottom: 10.h, top: 20.h),
                            ),
                        CustomButton(
                          pageCTA: 'Maybe Later',
                          color: InstaColors.lightColor,
                          buttonTextColor: InstaColors.darkColor,
                          buttonOnPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InstaDashboard(),
                              ),
                            );
                          },
                        )
                            .afmBorderRadius(
                              BorderRadius.circular(
                                50.r,
                              ),
                            )
                            .afmPadding(
                              EdgeInsets.only(bottom: 20.h),
                            ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
