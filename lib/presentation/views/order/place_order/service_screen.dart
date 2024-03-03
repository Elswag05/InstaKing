import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/controllers/insta_categories_controller.dart';
import 'package:insta_king/presentation/views/home/home_card_widgets.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'package:lottie/lottie.dart';

class ServiceScreen extends ConsumerStatefulWidget {
  const ServiceScreen({super.key});

  @override
  ConsumerState<ServiceScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<ServiceScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CategoriesController servicesControllerScreen =
      ref.watch(instaCategoriesController);

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Durations.long1, () {}),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: TransparentLoadingScreen()),
          ); // Show loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Lottie.asset(
            "assets/animation/null-animation.json",
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..repeat();
            },
          );
        } else {
          // Use ListView.builder with the data returned by toGetAllCategories
          List<ServiceItem> services =
              servicesControllerScreen.allServicesModel;
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
              ),
              title: Text(
                'Services',
                style: TextStyle(
                  fontFamily: 'Monteserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            body: SafeArea(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  ServiceItem servicesItem = services[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        servicesControllerScreen.setServiceValue(
                          servicesItem.id,
                          servicesItem.name,
                          servicesItem.price,
                        );
                      });
                      debugPrint(
                          'ID: ${servicesItem.id} and the service NAME: ${servicesItem.name}');
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.sp),
                          // margin: EdgeInsets.symmetric(
                          //   vertical: 10.w,
                          //   horizontal: 20.h,
                          // ),
                          height: 40.h,
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width - 40.w,
                          decoration: BoxDecoration(
                            color: InstaColors.lightColor,
                            border: Border.all(
                              color: Theme.of(context).shadowColor,
                              width: 0.5.sp,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: AutoSizeText(
                            servicesItem.name,
                            minFontSize: 12.sp,
                            stepGranularity: 2.sp,
                            style: TextStyle(
                              fontFamily: 'Monteserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              overflow: TextOverflow.ellipsis,
                              color: Theme.of(context).colorScheme.scrim,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "MIN ORDERS :  ${formatBalance(
                                servicesItem.min,
                                noShowNaira: true,
                              )}",
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ).afmPadding(EdgeInsets.symmetric(
                              vertical: 5.w,
                              horizontal: 10.h,
                            )),
                            Text(
                              "PRICE PER 1K : ${formatBalance(
                                servicesItem.price,
                                noShowNaira: false,
                              )}",
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ).afmPadding(EdgeInsets.symmetric(
                              vertical: 5.w,
                              horizontal: 10.h,
                            )),
                          ],
                        ),
                      ],
                    ).afmPadding(EdgeInsets.symmetric(
                      vertical: 10.w,
                      horizontal: 20.h,
                    )),
                  );
                },
              ),
            ),
          );
        }
      }),
    );
  }
}
