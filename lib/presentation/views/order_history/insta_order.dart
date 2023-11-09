import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/order_history/order_appBar.dart';
import 'package:insta_king/presentation/views/order_history/order_tabs/drip_feed.dart';
import 'package:insta_king/presentation/views/order_history/order_tabs/main_order_tabs.dart';
import 'package:insta_king/presentation/views/order_history/order_tabs/my_orders_view.dart';
import 'package:insta_king/presentation/views/order_history/order_tabs/order_widgets.dart';
import 'package:insta_king/presentation/views/order_history/order_tabs/subscriptions.dart';

class InstaOrderHistory extends StatefulWidget {
  const InstaOrderHistory({super.key});

  @override
  State<InstaOrderHistory> createState() => _InstaOrderHistoryState();
}

class _InstaOrderHistoryState extends State<InstaOrderHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _selectedIndex = 0;
  bool _isAllSelected = false;
  bool _isPendingSelected = false;
  bool _isRunningSelected = false;
  bool _isInProgressSelected = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: EnvColors.appBackgroundColor,
        body: Column(
          children: [
            const OrderAppBar().afmPadding(
              EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 20.sp),
            ),
            Container(
              color: EnvColors.lightColor,
              child: TabBar(
                isScrollable: true,
                padding: EdgeInsets.all(8.sp),
                indicator: CustomTabIndicator(),
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Text(
                      'My Orders',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 13.sp,
                        color: _selectedIndex == 0
                            ? EnvColors.lightColor
                            : EnvColors.darkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Drip Feed',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 13.sp,
                        color: _selectedIndex == 1
                            ? EnvColors.lightColor
                            : EnvColors.darkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Subscriptions',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 13.sp,
                        color: _selectedIndex == 2
                            ? EnvColors.lightColor
                            : EnvColors.darkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
                .afmBorderRadius(BorderRadius.circular(10.r))
                .afmPadding(EdgeInsets.symmetric(horizontal: 20.sp)),
            SizedBox(
              height: 50.h,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: [
                      OrderChips(
                        key: Key('one'),
                        isSelected: _isAllSelected,
                        onSelected: (_one) {
                          _isAllSelected = _one;
                          setState(() {});
                        },
                        label: 'All',
                      ),
                      OrderChips(
                        isSelected: _isPendingSelected,
                        onSelected: (_) {
                          _isPendingSelected = _;
                          setState(() {});
                        },
                        label: 'Pending',
                      ),
                      OrderChips(
                        isSelected: _isRunningSelected,
                        onSelected: (_) {
                          _isRunningSelected = _;
                          setState(() {});
                        },
                        label: 'Running',
                      ),
                      OrderChips(
                        isSelected: _isInProgressSelected,
                        onSelected: (_) {
                          _isInProgressSelected = _;
                          setState(() {});
                        },
                        label: 'In Progress',
                      ),
                    ],
                  ).afmPadding(
                      EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp)),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 500.h,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  MyOrder(),
                  DripFeed(),
                  Subscriptions(),
                ],
              ),
            )
                .afmPadding(
                    EdgeInsets.only(top: 20.sp, left: 20.sp, right: 20.sp))
                .afmNeverScroll,
          ],
        ).afmNeverScroll,
      ),
    );
  }
}
