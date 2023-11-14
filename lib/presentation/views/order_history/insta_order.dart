import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/order_history/order_appBar.dart';
import 'package:insta_king/presentation/views/order_history/order_chips.dart';
import 'package:insta_king/presentation/views/order_history/order_tabs/drip_feed.dart';
import 'package:insta_king/presentation/views/order_history/order_tabs/main_order_tabs.dart';
import 'package:insta_king/presentation/views/order_history/order_tabs/my_orders_view.dart';
import 'package:insta_king/presentation/views/order_history/order_tabs/subscriptions.dart';

class InstaOrderHistory extends StatefulWidget {
  const InstaOrderHistory({super.key});

  @override
  State<InstaOrderHistory> createState() => _InstaOrderHistoryState();
}

class _InstaOrderHistoryState extends State<InstaOrderHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // late int _selectedIndex = 0;
  bool _isAllSelected = true;
  bool _isPendingSelected = false;
  bool _isRunningSelected = false;
  bool _isInProgressSelected = false;
  bool _isCompletedSelected = false;
  bool _isPartialDoneSelected = false;
  bool _isCancelledSelected = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        // _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EnvColors.appBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const OrderAppBar(
              text: 'Orders',
            ).afmPadding(
              EdgeInsets.only(left: 20.sp, right: 20.sp),
            ),
            SizedBox(
              height: 50.h,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: [
                      OrderChips(
                        key: const Key('one'),
                        icon: Icons.filter_alt,
                        isSelected: _isAllSelected,
                        onSelected: (one) {
                          _isAllSelected = one;
                          setState(() {});
                        },
                        label: 'All Orders',
                      ),
                      OrderChips(
                        icon: Icons.file_open_rounded,
                        isSelected: _isPendingSelected,
                        onSelected: (_) {
                          _isPendingSelected = _;
                          setState(() {});
                        },
                        label: 'Order Received',
                      ),
                      OrderChips(
                        icon: Icons.change_circle_outlined,
                        isSelected: _isRunningSelected,
                        onSelected: (_) {
                          _isRunningSelected = _;
                          setState(() {});
                        },
                        label: 'In Progress',
                      ),
                      OrderChips(
                        icon: Icons.done,
                        isSelected: _isCompletedSelected,
                        onSelected: (_) {
                          _isCompletedSelected = _;
                          setState(() {});
                        },
                        label: 'Completed',
                      ),
                      OrderChips(
                        icon: Icons.timelapse_rounded,
                        isSelected: _isPartialDoneSelected,
                        onSelected: (_) {
                          _isPartialDoneSelected = _;
                          setState(() {});
                        },
                        label: 'Partially Completed',
                      ),
                      OrderChips(
                        icon: Icons.download,
                        isSelected: _isInProgressSelected,
                        onSelected: (_) {
                          _isInProgressSelected = _;
                          setState(() {});
                        },
                        label: 'Processing',
                      ),
                      OrderChips(
                        icon: Icons.cancel,
                        isSelected: _isCancelledSelected,
                        onSelected: (_) {
                          _isCancelledSelected = _;
                          setState(() {});
                        },
                        label: 'Cancelled',
                      ),
                    ],
                  ).afmPadding(
                      EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp)),
                ],
              ),
            ),
            // SizedBox(
            //   width: double.infinity,
            //   height: 500.h,
            //   child: TabBarView(
            //     controller: _tabController,
            //     children: const [
            //       // MyOrder(),
            //       // DripFeed(),
            //       Subscriptions(),
            //     ],
            //   ),
            // )
            //     .afmPadding(
            //         EdgeInsets.only(top: 20.sp, left: 20.sp, right: 20.sp))
            //     .afmNeverScroll,
            const OrderViews().afmPadding(EdgeInsets.only(
              top: 20.sp,
              left: 20.w,
              right: 20.w,
            )),
            const OrderViews().afmPadding(EdgeInsets.only(
              top: 20.sp,
              left: 20.w,
              right: 20.w,
            )),
            const OrderViews().afmPadding(EdgeInsets.only(
              top: 20.sp,
              left: 20.w,
              right: 20.w,
            )),
            const OrderViews().afmPadding(EdgeInsets.only(
              top: 20.sp,
              left: 20.w,
              right: 20.w,
            )),
            const OrderViews().afmPadding(EdgeInsets.only(
              top: 20.sp,
              left: 20.w,
              right: 20.w,
              bottom: 20.h,
            )),
          ],
        ).afmNeverScroll,
      ),
    );
  }
}


  // Container(
  //             color: EnvColors.lightColor,
  //             child: TabBar(
  //               isScrollable: true,
  //               padding: EdgeInsets.all(8.sp),
  //               indicator: CustomTabIndicator(),
  //               controller: _tabController,
  //               tabs: [
  //                 Tab(
  //                   child: Text(
  //                     'My Orders',
  //                     style: TextStyle(
  //                       fontFamily: 'Montesserat',
  //                       fontSize: 13.sp,
  //                       color: _selectedIndex == 0
  //                           ? EnvColors.lightColor
  //                           : EnvColors.darkColor,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //                 Tab(
  //                   child: Text(
  //                     'Drip Feed',
  //                     style: TextStyle(
  //                       fontFamily: 'Montesserat',
  //                       fontSize: 13.sp,
  //                       color: _selectedIndex == 1
  //                           ? EnvColors.lightColor
  //                           : EnvColors.darkColor,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //                 Tab(
  //                   child: Text(
  //                     'Subscriptions',
  //                     style: TextStyle(
  //                       fontFamily: 'Montesserat',
  //                       fontSize: 13.sp,
  //                       color: _selectedIndex == 2
  //                           ? EnvColors.lightColor
  //                           : EnvColors.darkColor,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           )
  //               .afmBorderRadius(BorderRadius.circular(10.r))
  //               .afmPadding(EdgeInsets.symmetric(horizontal: 20.sp)),