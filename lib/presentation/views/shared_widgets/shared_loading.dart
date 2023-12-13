import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class TransparentLoadingScreen extends StatefulWidget {
  const TransparentLoadingScreen({super.key});

  @override
  _TransparentLoadingScreenState createState() =>
      _TransparentLoadingScreenState();
}

class _TransparentLoadingScreenState extends State<TransparentLoadingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // _loadAnimation();
  }

  // void _loadAnimation() async {
  //   await _controller.load("assets/animation/insta-load.json");
  //   _controller
  //     ..duration = _controller.composition!.duration
  //     ..forward();
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Transparent background with BackdropFilter
        Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
                child: Lottie.asset(
                  "assets/animation/insta-load.json",
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..repeat();
                  },
                ),
              ),
            ),
          ),
        ),
        // Lottie animation in the middle
      ],
    );
  }
}
