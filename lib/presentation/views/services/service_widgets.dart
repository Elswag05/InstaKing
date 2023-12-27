import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

bool hasInstagramBeenTapped = false;
bool hasFacebookBeenTapped = false;
bool hasYoutubeBeenTapped = false;
bool hasSpotifyBeenTapped = false;
bool hasSnapchatBeenTapped = false;
bool hasTelegramBeenTapped = false;
bool hasAudiomackBeenTapped = false;
bool hasTiktokBeenTapped = false;
bool hasDeezerBeenTapped = false;

Text lightText(String lightText, BuildContext context) {
  return Text(
    lightText,
    style: TextStyle(
      fontFamily: 'Montesserat',
      fontWeight: FontWeight.w500,
      fontSize: 10.sp,
      color: Theme.of(context).unselectedWidgetColor,
    ),
  );
}

AutoSizeText darkText(String darkText, BuildContext context) {
  return AutoSizeText(
    darkText,
    minFontSize: 8.sp,
    stepGranularity: 2.sp,
    style: TextStyle(
      fontFamily: 'Montesserat',
      fontWeight: FontWeight.w500,
      fontSize: 11.sp,
    ),
  );
}

extension StringExtension on String {
  String roundUpToDecimalPlaces(int decimalPlaces) {
    double number = double.parse(this);
    final mod = 1 / (10 * decimalPlaces);
    double roundedNumber = ((number / mod).ceil() * mod);
    return roundedNumber.toStringAsFixed(decimalPlaces);
  }
}

class ServicesSearchBar extends StatelessWidget {
  final String searchText;
  const ServicesSearchBar({super.key, required this.searchText});

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
            searchText,
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
