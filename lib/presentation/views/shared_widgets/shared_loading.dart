import 'dart:ui';

import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    //return MediaQuery.of(context).platformBrightness == Brightness.light
    //  ?
    return Stack(
      children: [
        Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Center(
              child: Lottie.asset(
                "assets/animation/Insta-king-lighttt.json",
                controller: _controller,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..repeat();
                },
              ),
            ),
          ),
        ), // Lottie animation in the middle
      ],
    );
    // : Stack(
    //     children: [
    //       Scaffold(
    //         body: Container(
    //           color: Colors.transparent,
    //           alignment: Alignment.center,
    //           height: MediaQuery.of(context).size.height,
    //           width: MediaQuery.of(context).size.width,
    //           child: BackdropFilter(
    //             filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
    //             child: Center(
    //               child: Lottie.asset(
    //                 "assets/animation/insta-king-light.json",
    //                 controller: _controller,
    //                 onLoaded: (composition) {
    //                   _controller
    //                     ..duration = composition.duration
    //                     ..repeat();
    //                 },
    //               ),
    //             ),
    //           ),
    //         ),
    //       )

    //       // Lottie animation in the middle
    //     ],
    //   );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
