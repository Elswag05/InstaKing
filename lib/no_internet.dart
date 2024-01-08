import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_network_controller.dart';
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
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: _handleRefresh,
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: 150.w,
                height: 150.h,
                child: Center(
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
              ),
            ),
          ],
        ).afmNeverScroll,
      ),
    );
  }
}
