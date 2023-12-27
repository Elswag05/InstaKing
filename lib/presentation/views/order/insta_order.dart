import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_categories_controller.dart';
import 'package:insta_king/presentation/controllers/insta_order_controller.dart';
import 'package:insta_king/presentation/model/get_all_order_model.dart';
import 'package:insta_king/presentation/views/home/home_card_widgets.dart';
import 'package:insta_king/presentation/views/order/order_appbar.dart';
import 'package:insta_king/presentation/views/order/order_history_status.dart';
import 'package:insta_king/presentation/views/order/order_history_transactions_view_model.dart';
import 'package:insta_king/presentation/views/order/order_tabs/main_order_tabs.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'package:lottie/lottie.dart';

class InstaOrderHistory extends ConsumerStatefulWidget {
  const InstaOrderHistory({super.key});

  @override
  ConsumerState<InstaOrderHistory> createState() => _InstaOrderHistoryState();
}

class _InstaOrderHistoryState extends ConsumerState<InstaOrderHistory>
    with TickerProviderStateMixin {
  // late TabController _tabController;
  late final AnimationController _controller;
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
  late List<String> allOrderId;
  late List<String> serviceNames;

  late final order = ref.read(instaOrderController.notifier);

  _updateChipSelection(String chipKey) {
    setState(() {
      _isAllSelected = false;
      _isCompletedSelected = false;
      _isRunningSelected = false;
      _isPartialDoneSelected = false;
      _isInProgressSelected = false;
      _isCancelledSelected = false;

      switch (chipKey) {
        case 'one':
          _currentOrders = _allOrders ?? order.getAllOrderModel.data;
          _isAllSelected = true;
          setState(() {});
          break;
        case 'completed':
          _currentOrders =
              _completedOrders ?? order.getOrdersByStatus(Status.COMPLETED);
          _isCompletedSelected = true;
          break;
        case 'running':
          _currentOrders =
              _runningOrders ?? order.getOrdersByStatus(Status.PARTIAL);
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

  void getServices() {
    for (int i = 0; i < _currentOrders!.length; i++) {
      allOrderId.add(_currentOrders![i].serviceId!);
    }
    //log('Services ID ==> $allOrderId');
    getServiceNames(allOrderId);
  }

  List<String> getServiceNames(List<String> allOrderId) {
    // Initialize serviceNames as an empty list

    for (int i = 0; i < _currentOrders!.length; i++) {
      // Append to the existing serviceNames list
      serviceNames.addAll(
        ref
            .read(instaCategoriesController.notifier)
            .getAllServicesModel
            .data!
            .where((service) => service.id.toString().contains(allOrderId[i]))
            .map((service) => service.name ?? ""),
      );
      // debugPrint('Service Names ==> $serviceNames');
    }

    return serviceNames;
  }

  @override
  void initState() {
    _updateChipSelection('one');
    textController = TextEditingController();
    _controller = AnimationController(vsync: this);
    allOrderId = [];
    serviceNames = [];
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        Future(() async {
                          await _updateChipSelection('one');
                        });
                      },
                      label: 'All Orders',
                    ),
                    OrderChips(
                      icon: Icons.done,
                      isSelected: _isCompletedSelected,
                      onSelected: (_) {
                        Future(() async {
                          await _updateChipSelection('completed');
                        });
                      },
                      label: 'Completed',
                    ),
                    OrderChips(
                      icon: Icons.change_circle_outlined,
                      isSelected: _isRunningSelected,
                      onSelected: (_) {
                        Future(() async {
                          await _updateChipSelection('running');
                        });
                      },
                      label: 'In Progress',
                    ),
                    OrderChips(
                      icon: Icons.timelapse_rounded,
                      isSelected: _isPartialDoneSelected,
                      onSelected: (_) {
                        Future(() async {
                          await _updateChipSelection('partialDone');
                        });
                      },
                      label: 'Pending',
                    ),
                    OrderChips(
                      icon: Icons.download,
                      isSelected: _isInProgressSelected,
                      onSelected: (_) {
                        Future(() async {
                          await _updateChipSelection('inProgress');
                        });
                      },
                      label: 'Processing',
                    ),
                    OrderChips(
                      icon: Icons.cancel,
                      isSelected: _isCancelledSelected,
                      onSelected: (_) {
                        Future(() async {
                          await _updateChipSelection('cancelled');
                        });
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
              child: FutureBuilder(
                  future:
                      ref.read(instaOrderController.notifier).toGetAllOrders(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: _currentOrders?.length ?? 1,
                        itemBuilder: ((context, index) {
                          getServices();
                          ref.read(instaCategoriesController).getOneServiceName(
                              _currentOrders?[index].serviceId);
                          print("Xurrent order is ${_currentOrders?.length}");
                          return _currentOrders?.length != []
                              ? OrderHistoryViewModel(
                                  idText:
                                      _currentOrders?[index].id.toString() ??
                                          '',
                                  dateHere: _currentOrders?[index]
                                          .createdAt
                                          .toString() ??
                                      '',
                                  linkHere: _currentOrders?[index].link ?? '',
                                  priceHere: formatBalance(
                                      _currentOrders?[index].price ?? '0'),
                                  digitHere:
                                      _currentOrders?[index].startCounter ?? '',
                                  quantity:
                                      _currentOrders?[index].quantity ?? '',
                                  serviceHere: serviceNames[index],
                                  remNant: _currentOrders?[index].remain ?? '',
                                  status: StatusContainer(
                                    status: _currentOrders?[index].status ??
                                        Status.PENDING,
                                  ),
                                )
                              : SizedBox(
                                  height: 200.h,
                                  width: 200.w,
                                  child: Lottie.asset(
                                    "assets/animation/null-animation.json",
                                    controller: _controller,
                                    onLoaded: (composition) {
                                      _controller
                                        ..duration = composition.duration
                                        ..repeat();
                                    },
                                  ),
                                );
                        }),
                      );
                    } else {
                      return const TransparentLoadingScreen();
                    }
                  }))).afmPadding(
              EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h)),
        ],
      )
              .afmPadding(
                EdgeInsets.only(top: 10.sp),
              )
              .afmNeverScroll),
    );
  }
}
