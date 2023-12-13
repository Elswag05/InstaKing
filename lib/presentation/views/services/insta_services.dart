import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_categories_controller.dart';
import 'package:insta_king/presentation/views/services/tapped_status.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';

bool hasInstagramBeenTapped = false;
bool hasFacebookBeenTapped = false;
bool hasYoutubeBeenTapped = false;
bool hasSpotifyBeenTapped = false;
bool hasSnapchatBeenTapped = false;
bool hasTelegramBeenTapped = false;
bool hasAudiomackBeenTapped = false;
bool hasTiktokBeenTapped = false;
bool hasDeezerBeenTapped = false;

class InstaServices extends StatefulWidget {
  const InstaServices({super.key});

  @override
  State<InstaServices> createState() => _InstaServicesState();
}

class _InstaServicesState extends State<InstaServices> {
  void setOnlyOneTrue(String tappedItem) {
    // Reset all boolean variables to false
    hasInstagramBeenTapped = false;
    hasFacebookBeenTapped = false;
    hasYoutubeBeenTapped = false;
    hasSpotifyBeenTapped = false;
    hasSnapchatBeenTapped = false;
    hasTelegramBeenTapped = false;
    hasAudiomackBeenTapped = false;
    hasTiktokBeenTapped = false;
    hasDeezerBeenTapped = false;
    // Set the tappedItem to true
    switch (tappedItem) {
      case 'instagram':
        hasInstagramBeenTapped = true;
        debugPrint('insta set to tru');
        break;
      case 'facebook':
        hasFacebookBeenTapped = true;
        debugPrint('fb set to tru');
        break;
      case 'youtube':
        hasYoutubeBeenTapped = true;
        debugPrint('ytb set to tru');
        break;
      case 'spotify':
        hasSpotifyBeenTapped = true;
        debugPrint('spotify set to tru');
        break;
      case 'snapchat':
        hasSnapchatBeenTapped = true;
        debugPrint('snapchat set to tru');
        break;
      case 'telegram':
        hasTelegramBeenTapped = true;
        debugPrint('telegrm set to tru');
        break;
      case 'audiomack':
        hasAudiomackBeenTapped = true;
        debugPrint('adomck set to tru');
        break;
      case 'tiktok':
        hasTiktokBeenTapped = true;
        debugPrint('tiktk set to tru');
        break;
      case 'deezer':
        hasDeezerBeenTapped = true;
        debugPrint('dzr set to tru');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: ((context, ref, child) {
            final service = ref
                .read(instaCategoriesController.notifier)
                .getAllServicesModel;
            return Column(
              children: [
                const RecurringAppBar(appBarTitle: "Services")
                    .afmPadding(EdgeInsets.only(bottom: 5.h, top: 10.h)),
                const ServicesSearchBar(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // const Text(
                    //   'See all',
                    //   style: TextStyle(
                    //     fontFamily: 'Montesserat',
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    rows1(context, ref)
                        .afmPadding(EdgeInsets.symmetric(vertical: 10.sp)),
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
                    color: InstaColors.primaryColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    'All Services',
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      fontWeight: FontWeight.w500,
                      color: InstaColors.lightColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ).afmPadding(EdgeInsets.only(bottom: 20.sp)),
                FutureBuilder(
                    future: ref
                        .read(instaCategoriesController.notifier)
                        .toGetAllServiceDetail(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SizedBox(
                          height: 340.h,
                          width: MediaQuery.of(context).size.width - 40.sp,
                          child: ListView.builder(
                            itemCount: service.data?.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ServicesDemoWidget(index: index)
                                  .afmPadding(
                                EdgeInsets.only(bottom: 20.h),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(child: TransparentLoadingScreen());
                      }
                    })
              ],
            ).afmNeverScroll;
          }),
        ),
      ),
    );
  }

  Row rows1(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            ServicesIconTabs(
              imageIconPath: 'instagram',
              text: 'Instagram',
              isTapped: hasInstagramBeenTapped,
              onTap: () {
                setState(() {
                  ref
                      .read(instaCategoriesController.notifier)
                      .searchByName('instagram');
                  setOnlyOneTrue('instagram');
                });
              },
            ),
            ServicesIconTabs(
              imageIconPath: 'facebook (1)',
              text: 'Facebook',
              isTapped: hasFacebookBeenTapped,
              onTap: () {
                setState(() {
                  ref
                      .read(instaCategoriesController.notifier)
                      .searchByName('facebook');
                  setOnlyOneTrue('facebook');
                });
              },
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ServicesIconTabs(
              imageIconPath: 'play',
              text: 'Youtube',
              isTapped: hasYoutubeBeenTapped,
              onTap: () {
                setState(() {
                  ref
                      .read(instaCategoriesController.notifier)
                      .searchByName('youtube');
                  setOnlyOneTrue('youtube');
                });
              },
            ),
            ServicesIconTabs(
              imageIconPath: 'spotify',
              text: 'Spotify',
              isTapped: hasSpotifyBeenTapped,
              onTap: () {
                setState(() {
                  ref
                      .read(instaCategoriesController.notifier)
                      .searchByName('spotify');
                  setOnlyOneTrue('spotify');
                });
              },
            ),
          ],
        ),
        Column(
          children: [
            ServicesIconTabs(
              imageIconPath: 'snapchat (1)',
              text: 'Snapchat',
              isTapped: hasSnapchatBeenTapped,
              onTap: () {
                setState(() {
                  ref
                      .read(instaCategoriesController.notifier)
                      .searchByName('snapchat');
                  setOnlyOneTrue('snapchat');
                });
              },
            ),
            ServicesIconTabs(
              imageIconPath: 'instagram',
              text: 'Telegram',
              isTapped: hasTelegramBeenTapped,
              onTap: () {
                setState(() {
                  ref
                      .read(instaCategoriesController.notifier)
                      .searchByName('telegram');
                  setOnlyOneTrue('telegram');
                });
              },
            ),
          ],
        ),
        Column(
          children: [
            ServicesIconTabs(
              imageIconPath: 'facebook (1)',
              text: 'Audiomack',
              isTapped: hasAudiomackBeenTapped,
              onTap: () {
                setState(() {
                  ref
                      .read(instaCategoriesController.notifier)
                      .searchByName('audiomack');
                  setOnlyOneTrue('audiomack');
                });
              },
            ),
            ServicesIconTabs(
              imageIconPath: 'play',
              text: 'TikTok',
              isTapped: hasTiktokBeenTapped,
              onTap: () {
                setState(() {
                  ref
                      .read(instaCategoriesController.notifier)
                      .searchByName('tiktok');
                  setOnlyOneTrue('tiktok');
                });
              },
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ServicesIconTabs(
              imageIconPath: 'spotify',
              text: 'Deezer',
              isTapped: hasDeezerBeenTapped,
              onTap: () {
                setState(
                  () {
                    ref
                        .read(instaCategoriesController.notifier)
                        .searchByName('deezer');
                    setOnlyOneTrue('deezer');
                  },
                );
              },
            ),
            SizedBox(
              height: 70.h,
            )
          ],
        ),
      ],
    );
  }
}

class ServicesDemoWidget extends StatefulWidget {
  final int index;
  const ServicesDemoWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<ServicesDemoWidget> createState() => _ServicesDemoWidgetState();
}

class _ServicesDemoWidgetState extends State<ServicesDemoWidget> {
  // Initialize the tapped status object

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final service =
            ref.watch(instaCategoriesController.notifier).getAllServicesModel;
        // Get the filteredData object based on your logic
        final filteredData = ref
            .watch(instaCategoriesController.notifier)
            .filteredData; // Replace with your logic to get filteredData

        // Check if any of the boolean variables are true
        final bool hasTappedStatus = hasInstagramBeenTapped ||
            hasFacebookBeenTapped ||
            hasYoutubeBeenTapped ||
            hasSpotifyBeenTapped ||
            hasSnapchatBeenTapped ||
            hasTelegramBeenTapped ||
            hasAudiomackBeenTapped ||
            hasTiktokBeenTapped ||
            hasDeezerBeenTapped;

        print(hasTappedStatus.toString());
        return Container(
          width: MediaQuery.of(context).size.width - 40.sp,
          height: 140.h,
          padding: EdgeInsets.all(15.sp),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child:
              // hasTappedStatus
              //     ? Text('${filteredData.toString()}')
              //     :
              ServiceWidgetModel(
            IDtext: service.data?[widget.index].id.toString() ?? 'Loading...',
            name: service.data?[widget.index].name.toString() ?? 'Loading...',
            price: service.data?[widget.index].price
                    .toString()
                    .roundUpToDecimalPlaces(2) ??
                'Loading...',
            min: service.data?[widget.index].min.toString() ?? 'Loading...',
            max: service.data?[widget.index].max.toString() ?? '',
          ),
        );
      },
    );
  }
}

extension StringExtension on String {
  String roundUpToDecimalPlaces(int decimalPlaces) {
    double number = double.parse(this);
    final mod = 1 / (10 * decimalPlaces);
    double roundedNumber = ((number / mod).ceil() * mod);
    return roundedNumber.toStringAsFixed(decimalPlaces);
  }
}

class ServiceWidgetModel extends StatelessWidget {
  final String IDtext;
  final String min;
  final String max;
  final String name;
  final String price;

  const ServiceWidgetModel({
    super.key,
    required this.IDtext,
    required this.min,
    required this.max,
    required this.price,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        lightText('ID', context),
        Positioned(
          left: MediaQuery.of(context).size.width / 2.5.w,
          child: darkText(IDtext, context),
        ),
        Positioned(
          top: 20.h,
          child: lightText('NAME', context),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2.5.w,
          top: 20.h,
          child: Container(
            height: 47.h,
            width: 150,
            child: darkText('$name', context),
          ),
        ),
        Positioned(
          top: 75.h,
          child: lightText('PRICE PER 1000', context),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2.5.w,
          top: 75.h,
          child: SizedBox(
            height: 20.h,
            width: 80.w,
            child: darkText('₦$price', context),
          ),
        ),
        Positioned(
          top: 95.h,
          child: lightText('MIN - MAX', context),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2.5.w,
          top: 95.h,
          child: darkText('$min - $max', context),
        ),
      ],
    );
  }
}

Text lightText(String lightText, BuildContext context) {
  return Text(
    lightText,
    style: TextStyle(
      fontFamily: 'Montesserat',
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      color: Theme.of(context).unselectedWidgetColor,
    ),
  );
}

AutoSizeText darkText(String darkText, BuildContext context) {
  return AutoSizeText(
    darkText,
    minFontSize: 10.sp,
    stepGranularity: 2.sp,
    style: TextStyle(
      fontFamily: 'Montesserat',
      fontWeight: FontWeight.w500,
      fontSize: 13.sp,
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
              color:
                  InstaColors.containerGradient.elementAt(2).withOpacity(0.2),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Image.asset(
              EnvAssets.getIconPath(imageIconPath),
              // width: 15.w,
              // height: 15.h,
              color: isTapped ? null : InstaColors.mildGrey,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 11.sp,
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
        color: Theme.of(context).canvasColor,
        border: Border.all(
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
              fontWeight: FontWeight.w500,
            ),
          ).afmPadding(EdgeInsets.only(left: 10.w)),
          Icon(
            Icons.search,
            size: 20.sp,
          ).afmPadding(EdgeInsets.only(right: 6.h)),
        ],
      ),
    ).afmPadding(EdgeInsets.symmetric(horizontal: 20.sp));
  }
}
