import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_categories_controller.dart';
import 'package:insta_king/presentation/views/services/service_icon.dart';
import 'package:insta_king/presentation/views/services/service_widgets.dart';
import 'package:insta_king/presentation/views/services/services_demo.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';

class InstaServices extends StatefulWidget {
  const InstaServices({super.key});

  @override
  InstaServicesState createState() => InstaServicesState();
}

class InstaServicesState extends State<InstaServices> {
  late String selectedService;
  void setOnlyOneTrue(String tappedItem, WidgetRef ref) {
    resetAllBooleanVariables();
    switch (tappedItem) {
      case 'instagram':
        setState(() {
          hasInstagramBeenTapped = true;
          selectedService = 'Instagram Services';
        });
        break;
      case 'facebook':
        setState(() {
          hasFacebookBeenTapped = true;
          selectedService = 'Facebook Services';
        });
        break;
      case 'boomplay':
        setState(() {
          hasBoomplayBeenTapped = true;
          selectedService = 'Boomplay Services';
        });
        break;
      case 'youtube':
        setState(() {
          hasYoutubeBeenTapped = true;
          selectedService = 'Youtube Services';
        });
        break;
      case 'spotify':
        setState(() {
          hasSpotifyBeenTapped = true;
          selectedService = 'Spotify Services';
        });
        break;
      case 'snapchat':
        setState(() {
          hasSnapchatBeenTapped = true;
          selectedService = 'Snapchat Services';
        });
        break;
      case 'telegram':
        setState(() {
          hasTelegramBeenTapped = true;
          selectedService = 'Telegram Services';
        });
        break;
      case 'audiomack':
        setState(() {
          hasAudiomackBeenTapped = true;
          selectedService = 'Audiomack Services';
        });
        break;
      case 'tiktok':
        setState(() {
          hasTiktokBeenTapped = true;
          selectedService = 'Tiktok Services';
        });
        break;
      case 'deezer':
        setState(() {
          hasDeezerBeenTapped = true;
          selectedService = 'Deezer Services';
        });
        break;
      default:
        break;
    }
    debugPrint('$tappedItem has been tapped');
    ref.read(instaCategoriesController).searchByName(tappedItem);
  }

  void resetAllBooleanVariables() {
    hasInstagramBeenTapped = false;
    hasFacebookBeenTapped = false;
    hasBoomplayBeenTapped = false;
    hasYoutubeBeenTapped = false;
    hasSpotifyBeenTapped = false;
    hasSnapchatBeenTapped = false;
    hasTelegramBeenTapped = false;
    hasAudiomackBeenTapped = false;
    hasTiktokBeenTapped = false;
    hasDeezerBeenTapped = false;
  }

  @override
  void initState() {
    resetAllBooleanVariables();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final service =
                ref.watch(instaCategoriesController).servicesModel.length;
            return Column(
              children: [
                const RecurringAppBar(appBarTitle: "Services")
                    .afmPadding(EdgeInsets.only(bottom: 5.h, top: 10.h)),
                const ServicesSearchBar(
                  searchText: 'Search Services',
                ),
                _buildServiceRows(context, ref),
                _buildAllServicesContainer(context, ref),
                _buildServiceList(context, ref, service).afmPadding(
                  EdgeInsets.only(bottom: 20.h),
                ),
              ],
            ).afmNeverScroll;
          },
        ),
      ),
    );
  }

  Widget _buildServiceRows(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 10.w),
      child: Center(
        child: Wrap(
          spacing: 10.h,
          runSpacing: 5.h,
          alignment: WrapAlignment.start,
          children: [
            _buildServiceColumn(context, ref, 'instagram', 'Instagram'),
            _buildServiceColumn(context, ref, 'facebook', 'Facebook'),
            _buildServiceColumn(context, ref, 'boomplay', 'Boomplay'),
            _buildServiceColumn(context, ref, 'youtube', 'Youtube'),
            _buildServiceColumn(context, ref, 'spotify', 'Spotify'),
            _buildServiceColumn(context, ref, 'snapchat', 'Snapchat'),
            _buildServiceColumn(context, ref, 'telegram', 'Telegram'),
            _buildServiceColumn(context, ref, 'audiomack', 'Audiomack'),
            _buildServiceColumn(context, ref, 'tiktok', 'TikTok'),
            _buildServiceColumn(context, ref, 'deezer', 'Deezer'),
          ],
        ),
      ),
    );
  }

  Column _buildServiceColumn(
      BuildContext context, WidgetRef ref, String imagePath, String text) {
    return Column(
      children: [
        ServicesIconTabs(
          imageIconPath: imagePath,
          text: text,
          isTapped: _isServiceTapped(imagePath),
          onTap: () {
            setState(() {
              setOnlyOneTrue(imagePath, ref);
            });
          },
        ),
      ],
    );
  }

  bool _isServiceTapped(String serviceName) {
    switch (serviceName) {
      case 'instagram':
        return hasInstagramBeenTapped;
      case 'facebook':
        return hasFacebookBeenTapped;
      case 'boomplay':
        return hasBoomplayBeenTapped;
      case 'youtube':
        return hasYoutubeBeenTapped;
      case 'spotify':
        return hasSpotifyBeenTapped;
      case 'snapchat':
        return hasSnapchatBeenTapped;
      case 'telegram':
        return hasTelegramBeenTapped;
      case 'audiomack':
        return hasAudiomackBeenTapped;
      case 'tiktok':
        return hasTiktokBeenTapped;
      case 'deezer':
        return hasDeezerBeenTapped;
      default:
        return false;
    }
  }

  Widget _buildAllServicesContainer(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width - 40.sp,
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        color: InstaColors.primaryColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        ref.read(instaCategoriesController).hasTappedStatus
            ? selectedService
            : 'All Services',
        style: TextStyle(
          fontFamily: 'Montesserat',
          fontWeight: FontWeight.w500,
          color: InstaColors.lightColor,
          fontSize: 14.sp,
        ),
      ),
    ).afmPadding(EdgeInsets.only(bottom: 20.sp));
  }

  Widget _buildServiceList(
      BuildContext context, WidgetRef ref, dynamic service) {
    return FutureBuilder(
      future: ref.read(instaCategoriesController).toGetAllServiceDetail(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            height: 340.h,
            width: MediaQuery.of(context).size.width - 40.sp,
            child: ListView.builder(
              itemCount: service,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _buildServiceDemoWidget(index, ref).afmPadding(
                  EdgeInsets.symmetric(vertical: 5.h),
                );
              },
            ),
          );
        } else {
          return const TransparentLoadingScreen();
        }
      },
    );
  }

  ServicesDemoWidget _buildServiceDemoWidget(int index, WidgetRef ref) {
    return ServicesDemoWidget(index: index);
  }
}
