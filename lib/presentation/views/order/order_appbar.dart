import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';

class OrderAppBar extends StatefulWidget {
  final String text;
  final void Function(String) onSearch;
  final TextEditingController textController;

  const OrderAppBar(
      {super.key,
      required this.text,
      required this.onSearch,
      required this.textController});

  @override
  State<OrderAppBar> createState() => _OrderAppBarState();
}

class _OrderAppBarState extends State<OrderAppBar> {
  bool isSearchVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: !isSearchVisible,
          child: Text(
            widget.text,
            style: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // AnimSearchBar(
        //   width: MediaQuery.of(context).size.width - 200.w,
        //   textController: widget.textController,
        //   onSuffixTap: () {
        //     setState(() {
        //       isSearchVisible = !isSearchVisible;
        //       if (isSearchVisible) {
        //         // textController.clear();
        //       }
        //     });
        //   },
        //   onSubmitted: (string) {
        //     widget.onSearch;
        //   },
        //   color: InstaColors.primaryColor,
        //   helpText: "Search Orders...",
        //   autoFocus: true,
        //   closeSearchOnSuffixTap: true,
        //   animationDurationInMilli: 2000,
        //   rtl: true,
        // ),
      ],
    );
  }
}


        // IconButton(
        //   splashColor: InstaColors.darkColor,
        //   splashRadius: 25.r,
        //   icon: SvgPicture.asset(
        //     EnvAssets.getSvgPath('Search'),
        //     width: 20.w,
        //     height: 20.h,
        //     // ignore: deprecated_member_use
        //     color: Theme.of(context).unselectedWidgetColor,
        //     semanticsLabel: 'Search',
        //   ),
        //   onPressed: () {
        //     // ignore: avoid_print
        //     print('INFO: You just prompted search');
        //   },
        //   tooltip: 'search',
        //   highlightColor: InstaColors.primaryColor,
        // ), //.afmPadding(EdgeInsets.only(left: 10.w)),