import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_assets.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_login_controller.dart';
import 'package:insta_king/presentation/views/dashboard/insta_dashboard.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:text_3d/text_3d.dart';

class PostSignUp extends StatefulWidget {
  const PostSignUp({super.key});

  @override
  State<PostSignUp> createState() => _PostSignUpState();
}

class _PostSignUpState extends State<PostSignUp> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  int animationCount = 0;
  bool isPlaying = false;
  final controller = ConfettiController();

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        isPlaying = controller.state == ConfettiControllerState.playing;
      });
    });
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    _playAnimation();
    super.initState();
  }

  void _playAnimation() {
    _controller.forward().then((_) {
      _controller.reverse().then((_) {
        if (animationCount < 4) {
          animationCount++;
          _playAnimation();
          isPlaying = true;
        } else {
          isPlaying = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
                SizeTransition(
                  sizeFactor: _animation,
                  axis: Axis.horizontal,
                  axisAlignment: 2,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ThreeDText(
                      text: 'Congratulations!!!',
                      textStyle: TextStyle(
                        fontFamily: 'Monteserrat',
                        fontSize: 30.sp,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                      depth: 7,
                      style: ThreeDStyle.standard,
                    ),
                  ),
                ).afmPadding(
                  EdgeInsets.only(top: 40.h),
                ),
                Image.asset(
                  EnvAssets.getImagePath('congratulations'),
                  width: 400.w,
                  height: 400.h,
                ),
                ConfettiWidget(
                  confettiController: controller,
                  shouldLoop: true,
                  blastDirection: pi / 2,
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
                              ref.read(instaLoginController).toCheckBox(true);
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
