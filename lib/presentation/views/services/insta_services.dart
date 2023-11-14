import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

class InstaServices extends StatefulWidget {
  const InstaServices({super.key});

  @override
  State<InstaServices> createState() => _InstaServicesState();
}

class _InstaServicesState extends State<InstaServices> {
  bool hasInstagramBeenTapped = true;
  bool hasFacebookBeenTapped = false;
  bool hasYoutubeBeenTapped = false;
  bool hasSpotifyBeenTapped = false;
  bool hasSnapchatBeenTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EnvColors.appBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const RecurringAppBar(appBarTitle: "Services")
                .afmPadding(EdgeInsets.only(bottom: 5.h)),
            const ServicesSearchBar(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'See all',
                  style: TextStyle(
                    fontFamily: 'Montesserat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ServicesIconTabs(
                      imageIconPath: 'instagram',
                      text: 'Instagram',
                      isTapped: hasInstagramBeenTapped,
                      onTap: () {
                        setState(() {
                          hasInstagramBeenTapped = !hasInstagramBeenTapped;
                        });
                      },
                    ),
                    ServicesIconTabs(
                      imageIconPath: 'facebook (1)',
                      text: 'Facebook',
                      isTapped: hasFacebookBeenTapped,
                      onTap: () {
                        setState(() {
                          hasFacebookBeenTapped = !hasFacebookBeenTapped;
                        });
                      },
                    ),
                    ServicesIconTabs(
                      imageIconPath: 'play',
                      text: 'Youtube',
                      isTapped: hasYoutubeBeenTapped,
                      onTap: () {
                        setState(() {
                          hasYoutubeBeenTapped = !hasYoutubeBeenTapped;
                        });
                      },
                    ),
                    ServicesIconTabs(
                      imageIconPath: 'spotify',
                      text: 'Spotify',
                      isTapped: hasSpotifyBeenTapped,
                      onTap: () {
                        setState(() {
                          hasSpotifyBeenTapped = !hasSpotifyBeenTapped;
                        });
                      },
                    ),
                    ServicesIconTabs(
                      imageIconPath: 'snapchat (1)',
                      text: 'Snapchat',
                      isTapped: hasSnapchatBeenTapped,
                      onTap: () {
                        setState(() {
                          hasSnapchatBeenTapped = !hasSnapchatBeenTapped;
                        });
                      },
                    ),
                  ],
                ).afmPadding(EdgeInsets.symmetric(vertical: 10.sp)),
              ],
            ).afmPadding(
              EdgeInsets.only(
                left: 20.sp,
                right: 20.sp,
                top: 20.sp,
                bottom: 10.sp,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40.sp,
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                color: EnvColors.primaryColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'Instagram - Autolikes / Autoviews \n[For New & Old Posts]',
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontWeight: FontWeight.w500,
                  color: EnvColors.lightColor,
                  fontSize: 14.sp,
                ),
              ),
            ).afmPadding(EdgeInsets.only(bottom: 20.sp)),
            const ServicesDemoWidget()
                .afmPadding(EdgeInsets.only(bottom: 20.sp)),
            const ServicesDemoWidget()
                .afmPadding(EdgeInsets.only(bottom: 20.sp)),
            const ServicesDemoWidget()
                .afmPadding(EdgeInsets.only(bottom: 20.sp)),
          ],
        ).afmNeverScroll,
      ),
    );
  }
}

class ServicesDemoWidget extends StatelessWidget {
  const ServicesDemoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40.sp,
      height: 140.h,
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        color: EnvColors.lightColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: [
          lightText('ID'),
          Positioned(
            right: MediaQuery.of(context).size.width / 3,
            child: darkText('9065'),
          ),
          Positioned(
            top: 20.h,
            child: lightText('NAME'),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width / 150,
            top: 20.h,
            child: darkText(
                'Instagram - Autolikes \n/ Autoviews [For New \n& Old Posts]'),
          ),
          Positioned(
            top: 75.h,
            child: lightText('PRICE PER 1000'),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width / 3.9,
            top: 75.h,
            child: darkText('#1,890.60'),
          ),
          Positioned(
            top: 95.h,
            child: lightText('MIN - MAX'),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width / 5,
            top: 95.h,
            child: darkText('100 - 30,000'),
          ),
        ],
      ),
    );
  }
}

Text lightText(String lightText) {
  return Text(
    lightText,
    style: TextStyle(
      fontFamily: 'Montesserat',
      fontWeight: FontWeight.w500,
      color: EnvColors.mildGrey.withOpacity(0.7),
      fontSize: 14.sp,
    ),
  );
}

Text darkText(String darkText) {
  return Text(
    darkText,
    style: TextStyle(
      fontFamily: 'Montesserat',
      fontWeight: FontWeight.w500,
      color: EnvColors.darkColor,
      fontSize: 14.sp,
    ),
  );
}

class ServicesIconTabs extends StatelessWidget {
  final String imageIconPath;
  final String text;
  final bool isTapped;
  final void Function()? onTap;
  const ServicesIconTabs(
      {super.key,
      required this.imageIconPath,
      required this.text,
      this.isTapped = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.sp),
            width: 50.w,
            height: 45.h,
            decoration: BoxDecoration(
              color: EnvColors.containerGradient.elementAt(2).withOpacity(0.2),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Image.asset(
              EnvAssets.getIconPath(imageIconPath),
              // width: 15.w,
              // height: 15.h,
              color: isTapped ? null : EnvColors.mildGrey,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Montesserat',
            ),
          ).afmPadding(EdgeInsets.symmetric(vertical: 5.h)),
        ],
      ),
    );
  }
}

class ServicesSearchBar extends StatelessWidget {
  const ServicesSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: EnvColors.lightColor,
        border: Border.all(
          color: EnvColors.darkColor.withOpacity(0.5),
          width: 1.sp,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Search Service',
            style: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 13.sp,
              color: EnvColors.darkColor.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ).afmPadding(EdgeInsets.only(left: 10.w)),
          Icon(
            Icons.search,
            size: 20.sp,
            color: EnvColors.darkColor.withOpacity(0.5),
          ).afmPadding(EdgeInsets.only(right: 6.h)),
        ],
      ),
    ).afmPadding(EdgeInsets.symmetric(horizontal: 20.sp));
  }
}
