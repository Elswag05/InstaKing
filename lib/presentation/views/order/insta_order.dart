import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_categories_controller.dart';
import 'package:insta_king/presentation/controllers/insta_order_controller.dart';
import 'package:insta_king/presentation/model/get_all_order_model.dart';
import 'package:insta_king/presentation/views/order/order_appbar.dart';
import 'package:insta_king/presentation/views/order/order_history_status.dart';
import 'package:insta_king/presentation/views/order/order_history_transactions_view_model.dart';
import 'package:insta_king/presentation/views/order/order_tabs/main_order_tabs.dart';

class InstaOrderHistory extends ConsumerStatefulWidget {
  const InstaOrderHistory({super.key});

  @override
  ConsumerState<InstaOrderHistory> createState() => _InstaOrderHistoryState();
}

class _InstaOrderHistoryState extends ConsumerState<InstaOrderHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // late int _selectedIndex = 0;
  late TextEditingController textController;
  bool _isAllSelected = true;
  bool _isRunningSelected = false;
  bool _isInProgressSelected = false;
  bool _isCompletedSelected = false;
  bool _isPartialDoneSelected = false;
  bool _isCancelledSelected = false;
  List<Datum>? _allOrders;
  List<Datum>? _completedOrders;
  List<Datum>? _runningOrders;
  List<Datum>? _partialDoneOrders;
  List<Datum>? _inProgressOrders;
  List<Datum>? _cancelledOrders;
  List<Datum>? _currentOrders;
  //String _searchQuery = '';

  late final order = ref.read(instaOrderController.notifier);

  // void _updateSearchQuery(String query) {
  //   setState(() {
  //     _searchQuery = query;
  //   });
  // }

  void _updateChipSelection(String chipKey) {
    setState(() {
      _isAllSelected = false;
      _isCompletedSelected = false;
      _isRunningSelected = false;
      _isPartialDoneSelected = false;
      _isInProgressSelected = false;
      _isCancelledSelected = false;

      switch (chipKey) {
        case 'one':
          setState(() {
            _currentOrders = _allOrders ?? order.getAllOrderModel.data;
            _isAllSelected = true;
          });
          break;
        case 'completed':
          _currentOrders =
              _completedOrders ?? order.getOrdersByStatus(Status.COMPLETED);
          _isCompletedSelected = true;
          break;
        case 'running':
          _currentOrders =
              _runningOrders ?? order.getOrdersByStatus(Status.INPROGRESS);
          _isRunningSelected = true;
          break;
        case 'partialDone':
          _currentOrders =
              _partialDoneOrders ?? order.getOrdersByStatus(Status.PENDING);
          _isPartialDoneSelected = true;
          break;
        case 'inProgress':
          _currentOrders =
              _inProgressOrders ?? order.getOrdersByStatus(Status.PROCESSING);
          _isInProgressSelected = true;
          break;
        case 'cancelled':
          _currentOrders =
              _cancelledOrders ?? order.getOrdersByStatus(Status.CANCELED);
          _isCancelledSelected = true;
          break;
      }
    });
  }

  List<Datum> _filterOrders(String query) {
    if (query.isEmpty) {
      return _currentOrders ?? [];
    }

    return _currentOrders
            ?.where((order) =>
                order.link!.toLowerCase().contains(query.toLowerCase()) ||
                ref
                    .read(instaCatValueProvider)
                    .getOneServiceDetailsModel
                    .data!
                    .name!
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                order.createdAt.toString().contains(query.toLowerCase()))
            .toList() ??
        [];
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      // setState(() {
      //   // _selectedIndex = _tabController.index;
      // });
      // ignore: avoid_print
      //print("Selected Index: ${_tabController.index}");
    });
    _updateChipSelection('one');
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<Datum>? filteredOrders = _filterOrders(_searchQuery);
    // _currentOrders = filteredOrders;

    // if (filteredOrders.isNotEmpty && filteredOrders != []) {
    //   _currentOrders = filteredOrders;
    // }
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          OrderAppBar(
            text: 'Order History',
            textController: textController,
            onSearch: (value) {},
          ).afmPadding(
            EdgeInsets.symmetric(horizontal: 20.w),
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
                        _updateChipSelection('one');
                      },
                      label: 'All Orders',
                    ),
                    OrderChips(
                      icon: Icons.done,
                      isSelected: _isCompletedSelected,
                      onSelected: (_) {
                        _updateChipSelection('completed');
                      },
                      label: 'Completed',
                    ),
                    OrderChips(
                      icon: Icons.change_circle_outlined,
                      isSelected: _isRunningSelected,
                      onSelected: (_) {
                        _updateChipSelection('running');
                      },
                      label: 'In Progress',
                    ),
                    OrderChips(
                      icon: Icons.timelapse_rounded,
                      isSelected: _isPartialDoneSelected,
                      onSelected: (_) {
                        _updateChipSelection('partialDone');
                      },
                      label: 'Pending',
                    ),
                    OrderChips(
                      icon: Icons.download,
                      isSelected: _isInProgressSelected,
                      onSelected: (_) {
                        _updateChipSelection('inProgress');
                      },
                      label: 'Processing',
                    ),
                    OrderChips(
                      icon: Icons.cancel,
                      isSelected: _isCancelledSelected,
                      onSelected: (_) {
                        _updateChipSelection('cancelled');
                      },
                      label: 'Cancelled',
                    ),
                  ],
                ).afmPadding(
                    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp)),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 180.h,
            child: ListView.builder(
              itemCount: _currentOrders?.length ?? 0,
              itemBuilder: ((context, index) {
                ref.watch(instaCategoriesProvider).getOneServiceName(
                    _currentOrders?[index].serviceId.toString());
                return OrderHistoryViewModel(
                  idText: _currentOrders?[index].id.toString() ?? '',
                  dateHere: _currentOrders?[index].createdAt.toString() ?? '',
                  linkHere: _currentOrders?[index].link ?? '',
                  priceHere: _currentOrders?[index].price ?? '',
                  digitHere: _currentOrders?[index].startCounter ?? '',
                  quantity: _currentOrders?[index].quantity ?? '',
                  serviceHere: ref
                          .read(instaCatValueProvider)
                          .getOneServiceDetailsModel
                          .data
                          ?.name ??
                      '',
                  remNant: _currentOrders?[index].remain ?? '',
                  status: StatusContainer(
                    status: _currentOrders?[index].status ?? Status.PENDING,
                  ),
                );
              }),
            ).afmGetFuture(order.toGetAllOrders()),
          ).afmPadding(EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h)),
        ],
      )
              .afmPadding(
                EdgeInsets.only(top: 10.sp),
              )
              .afmNeverScroll),
    );
  }
}


///These were modifications we needed to make, possible code to come back to 
///Save them for me
  // AnnouncementViews(
                    //   header: order.getAllOrderModel.data?[index].name ?? '',
                    //   body: order.getAllOrderModel.data?[index].amount ?? '',
                    //   date:
                    //       order.getAllOrderModel.data?[index].apiOrderId ?? '',
                    // );


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