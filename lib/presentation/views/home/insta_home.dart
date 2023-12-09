import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/model/profile_model.dart';
import 'package:insta_king/presentation/views/home/home_card_widgets.dart';
import 'package:insta_king/presentation/views/home/home_container_widget.dart';
import 'package:insta_king/presentation/views/home/home_head.dart';
import 'package:insta_king/presentation/views/home/home_shortcut_widgets.dart';
import 'package:insta_king/presentation/views/profile/insta_profile.dart';

class InstaHome extends StatefulWidget {
  const InstaHome({
    super.key,
  });

  @override
  State<InstaHome> createState() => _InstaHomeState();
}

class _InstaHomeState extends State<InstaHome> {
  late ProfileModel apiData;
  bool hasFetchedDetails = false;

  @override
  void initState() {
    apiData = ProfileModel();
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(builder: (context, ref, child) {
          if (!hasFetchedDetails) {
            // Fetch details only if they haven't been fetched yet
            Future(() async {
              await ref
                  .read(instaProfileController.notifier)
                  .getProfileDetails()
                  .then((value) {
                setState(() {});
                apiData = ref.watch(instaProfileController.notifier).model;
                hasFetchedDetails = true; // Set the flag after fetching details
              });
            });
          }
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
              hasFetchedDetails = false;
            },
            child: Column(
              children: [
                HomeHeaderWidget(
                  //imageFile: ref.watch(instaProfileController.notifier).image!,
                  username: apiData.user?.username ?? 'User',
                  onNotificationsTap: () {},
                  onProfileTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const InstaProfile(),
                      ),
                    );
                  },
                ).afmPadding(EdgeInsets.only(
                    left: 20.sp, right: 20.sp, top: 5.sp, bottom: 20.h)),
                HomeCardList(
                  totalBalance: apiData.user?.balance ?? '',
                  totalBonus: apiData.user?.bonus ?? '',
                  affiliateLink:
                      'https://instaking.ng/signup?ref=${apiData.user!.username}',
                ),
                HomeContainer(
                  color: Theme.of(context).cardColor,
                  height: 150.h,
                  child: const ShortcutsTheWidget(),
                )
                    .afmBorderRadius(BorderRadius.circular(24.r))
                    .afmPadding(EdgeInsets.only(bottom: 25.h)),
                Container(
                  height: 100.h,
                  width: MediaQuery.of(context).size.width - 40.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: InstaColors.containerGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: const [0, 0.2, 0.5, 0.8],
                    ),
                  ),
                  child: Row(),
                )
                    .afmBorderRadius(BorderRadius.circular(24.r))
                    .afmPadding(EdgeInsets.only(bottom: 25.h)),
                Stack(
                  children: [
                    HomeContainer(
                      color: Theme.of(context).cardColor,
                      height: 150.h,
                    )
                        .afmBorderRadius(BorderRadius.circular(24.r))
                        .afmPadding(EdgeInsets.only(bottom: 20.h)),
                    Container(
                      height: 40.h,
                      width: MediaQuery.of(context).size.width - 40.sp,
                      padding: EdgeInsets.only(left: 25.sp, top: 15.sp),
                      child: Text(
                        'Recent Transactions',
                        style: TextStyle(
                          fontFamily: 'Montesserat',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ).afmBorderRadius(BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r))),
                  ],
                ),
              ],
            ).afmNeverScroll,
          );
        }),
      ),
    );
  }
}
