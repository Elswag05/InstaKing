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

  Future<void> _updateChipSelection(String chipKey) async {
    bool isAllSelected = false;
    bool isCompletedSelected = false;
    bool isRunningSelected = false;
    bool isPartialDoneSelected = false;
    bool isInProgressSelected = false;
    bool isCancelledSelected = false;

    switch (chipKey) {
      case 'one':
        _currentOrders =
            _allOrders ?? ref.read(instaOrderController).getAllOrderModel.data;
        isAllSelected = true;
        break;
      case 'completed':
        _currentOrders = _completedOrders ??
            ref.read(instaOrderController).getOrdersByStatus(Status.COMPLETED);
        isCompletedSelected = true;
        break;
      case 'running':
        _currentOrders = _runningOrders ??
            ref.read(instaOrderController).getOrdersByStatus(Status.PARTIAL);
        isRunningSelected = true;
        break;
      case 'partialDone':
        _currentOrders = _partialDoneOrders ??
            ref.read(instaOrderController).getOrdersByStatus(Status.PENDING);
        isPartialDoneSelected = true;
        break;
      case 'inProgress':
        _currentOrders = _inProgressOrders ??
            ref.read(instaOrderController).getOrdersByStatus(Status.PROCESSING);
        isInProgressSelected = true;
        break;
      case 'cancelled':
        _currentOrders = _cancelledOrders ??
            ref.read(instaOrderController).getOrdersByStatus(Status.CANCELED);
        isCancelledSelected = true;
        break;
    }

    setState(() {
      _isAllSelected = isAllSelected;
      _isCompletedSelected = isCompletedSelected;
      _isRunningSelected = isRunningSelected;
      _isPartialDoneSelected = isPartialDoneSelected;
      _isInProgressSelected = isInProgressSelected;
      _isCancelledSelected = isCancelledSelected;
    });
  }

  // void getServices() {
  //   for (int i = 0; i < _currentOrders!.length; i++) {
  //     allOrderId.add(_currentOrders![i].serviceId!);
  //   }
  //   log('Services ID ==> $allOrderId');
  //   getServiceNames(allOrderId);
  // }

  List<String> extractFourDigitNumbers(String input) {
    RegExp regex = RegExp(r'\b\d{2,4}\b');
    Iterable<Match> matches = regex.allMatches(input);

    List<String> fourDigitNumbers =
        matches.map((match) => match.group(0)!).toList();

    return fourDigitNumbers;
  }

  void getServices() {
    allOrderId = [];
    for (int i = 0; i < _currentOrders!.length; i++) {
      String serviceId = _currentOrders![i].serviceId!;
      List<String> fourDigitNumbers = extractFourDigitNumbers(serviceId);

      // Add only the 4-digit numbers to allOrderId
      allOrderId.addAll(fourDigitNumbers);
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
      debugPrint('Service Names ==> $serviceNames');
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
              EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 5.h,
              ),
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
            Consumer(
              builder: ((context, ref, child) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height - 180.h,
                    child: FutureBuilder(
                        future: ref.read(instaOrderController).toGetAllOrders(),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (_currentOrders != null ||
                                _currentOrders != [] ||
                                _currentOrders!.isEmpty) {
                              debugPrint(
                                  'Length of orders ==> ${_currentOrders?.length}');
                              return ListView.builder(
                                itemCount: _currentOrders?.length ?? 0,
                                itemBuilder: ((context, index) {
                                  return OrderHistoryViewModel(
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
                                        _currentOrders?[index].startCounter ??
                                            '',
                                    quantity:
                                        _currentOrders?[index].quantity ?? '',
                                    serviceHere: ref
                                            .read(instaCategoriesController)
                                            .getOneServiceDetailsModel
                                            .data
                                            ?.name ??
                                        '',
                                    remNant:
                                        _currentOrders?[index].remain ?? '',
                                    status: StatusContainer(
                                      status: _currentOrders?[index].status ??
                                          Status.PENDING,
                                    ),
                                  ).afmGetFuture(
                                    Future(
                                      () => ref
                                          .read(instaCategoriesController)
                                          .getOneServiceName(
                                            _currentOrders?[index].serviceId,
                                          ),
                                    ),
                                  );
                                }),
                              );
                            } else {
                              return Lottie.asset(
                                "assets/animation/null-animation.json",
                                controller: _controller,
                                onLoaded: (composition) {
                                  _controller
                                    ..duration = composition.duration
                                    ..repeat();
                                },
                              );
                            }
                          } else {
                            return const TransparentLoadingScreen();
                          }
                        }))).afmPadding(
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h),
                );
              }),
            )
          ],
        )
            .afmPadding(
              EdgeInsets.only(top: 10.sp),
            )
            .afmNeverScroll,
      ),
    );
  }
}
