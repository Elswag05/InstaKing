import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/controllers/insta_network_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends ConsumerStatefulWidget {
  const NoInternet({super.key});

  @override
  ConsumerState<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends ConsumerState<NoInternet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late NetworkConnectivity networkConnectivity;

  @override
  void initState() {
    super.initState();
    networkConnectivity = NetworkConnectivity.instance;
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    // Check for internet connection or perform any other refresh-related logic
    networkConnectivity.initialise();
    if (networkConnectivity.isDeviceOnline) {
      debugPrint('Refreshing data...');
      await Future.delayed(const Duration(seconds: 2));
      // Navigator.pop(context);
      setState(() {});
      debugPrint('Refresh complete!');
    } else {
      debugPrint('No internet connection. Unable to refresh.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300.w,
              height: 300.h,
              child: Lottie.asset(
                "assets/animation/no_internet.json",
                controller: _controller,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..repeat();
                },
              ),
            ),
            Text(
              'Please check your internet connection\n',
              style: TextStyle(
                fontFamily: 'Monteserrat',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            CustomButton(
                pageCTA: 'Refresh Page',
                buttonOnPressed: () {
                  _handleRefresh();
                  setState(() {});
                }),
          ],
        ).afmNeverScroll,
      ).afmPadding(
        EdgeInsets.only(
          bottom: 50.h,
        ),
      ),
    );
  }
}
