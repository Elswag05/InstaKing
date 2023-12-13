import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_order_controller.dart';
import 'package:insta_king/presentation/views/order/order_appbar.dart';
import 'package:insta_king/presentation/views/order/order_chips.dart';
import 'package:insta_king/presentation/views/order/order_tabs/main_order_tabs.dart';

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
      // ignore: avoid_print
      print("Selected Index: ${_tabController.index}");
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
      body: SafeArea(child: Consumer(
        builder: (context, ref, child) {
          final order = ref.read(instaOrderController.notifier);
          return Column(
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
                    ).afmPadding(EdgeInsets.symmetric(
                        vertical: 10.sp, horizontal: 20.sp)),
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

              SizedBox(
                height: 800.h,
                width: MediaQuery.of(context).size.width - 40.sp,
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 20.h, top: 20.h),
                  itemCount: order.getAllOrderModel.username?.length ?? 2,
                  itemBuilder: ((context, index) {
                    return OrderViews(
                      header: order.getAllOrderModel.name.toString(),
                      body: order.getAllOrderModel.media.toString(),
                      date: order.getAllOrderModel.createdAt.toString(),
                    );
                  }),
                ),
              ).afmGetFuture(order.toGetAllOrders()),
            ],
          )
              .afmPadding(
                EdgeInsets.only(top: 10.sp),
              )
              .afmNeverScroll;
        },
      )),
    );
  }
}


  // Container(
  //             color: InstaColors.lightColor,
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
  //                           ? InstaColors.lightColor
  //                           : InstaColors.darkColor,
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
  //                           ? InstaColors.lightColor
  //                           : InstaColors.darkColor,
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
  //                           ? InstaColors.lightColor
  //                           : InstaColors.darkColor,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           )
  //               .afmBorderRadius(BorderRadius.circular(10.r))
  //               .afmPadding(EdgeInsets.symmetric(horizontal: 20.sp)),