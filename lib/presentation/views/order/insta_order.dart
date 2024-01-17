import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_categories_controller.dart';
import 'package:insta_king/presentation/controllers/insta_order_controller.dart';
import 'package:insta_king/presentation/model/get_all_order_model.dart';
import 'package:insta_king/presentation/views/home/home_card_widgets.dart';
import 'package:insta_king/presentation/views/order/order_appbar.dart';
import 'package:insta_king/presentation/views/order/order_history_status.dart';
import 'package:insta_king/presentation/views/order/order_history_transactions_view_model.dart';
import 'package:insta_king/presentation/views/order/order_tabs/main_order_tabs.dart';
import 'package:insta_king/presentation/views/order/place_order/place_order.dart';
import 'package:insta_king/presentation/views/shared_widgets/insta_webview.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OrderAppBar(
              text: 'My Orders',
              textController: textController,
              onTap: () {
                Future.delayed(Duration.zero, () async {
                  ref
                      .read(instaCategoriesController.notifier)
                      .toGetAllCategories;
                });
                ref.read(instaCategoriesController).toGetAllCategories();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PlaceOrder(),
                  ),
                );
              },
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
                              if (ref.read(instaOrderController).callReload) {}
                              return RefreshIndicator(
                                onRefresh: () async {
                                  ref
                                      .watch(instaOrderController)
                                      .setReloadTrue();
                                  ref
                                      .read(instaOrderController)
                                      .toGetAllOrders()
                                      .then((value) {
                                    ref
                                        .read(instaOrderController)
                                        .setRealoadFalse();
                                  });
                                },
                                child: AnimationLimiter(
                                  child: ListView.builder(
                                    itemCount: _currentOrders?.length ?? 0,
                                    physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(),
                                    ),
                                    itemBuilder: ((context, index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                              position: index,
                                              delay: const Duration(
                                                milliseconds: 100,
                                              ),
                                              child: SlideAnimation(
                                                duration: const Duration(
                                                    milliseconds: 2500),
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn,
                                                horizontalOffset: 30,
                                                verticalOffset: 300.0,
                                                child: FlipAnimation(
                                                  duration: const Duration(
                                                    milliseconds: 3000,
                                                  ),
                                                  curve: Curves
                                                      .fastLinearToSlowEaseIn,
                                                  flipAxis: FlipAxis.y,
                                                  child: OrderHistoryViewModel(
                                                    idText:
                                                        _currentOrders?[index]
                                                                .id
                                                                .toString() ??
                                                            '',
                                                    dateHere:
                                                        _currentOrders?[index]
                                                                .createdAt
                                                                .toString() ??
                                                            '',
                                                    linkHere:
                                                        _currentOrders?[index]
                                                                .link ??
                                                            '',
                                                    priceHere: formatBalance(
                                                        _currentOrders?[index]
                                                                .price ??
                                                            '0'),
                                                    digitHere:
                                                        _currentOrders?[index]
                                                                .startCounter ??
                                                            '',
                                                    quantity:
                                                        _currentOrders?[index]
                                                                .quantity ??
                                                            '',
                                                    serviceHere:
                                                        _currentOrders?[index]
                                                                .serviceName ??
                                                            '',
                                                    remNant:
                                                        _currentOrders?[index]
                                                                .remain ??
                                                            '',
                                                    status: StatusContainer(
                                                      status:
                                                          _currentOrders?[index]
                                                                  .status ??
                                                              Status.PENDING,
                                                    ),
                                                    onLinkTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              WebViewKit(
                                                            linkString:
                                                                _currentOrders?[
                                                                            index]
                                                                        .link ??
                                                                    'jayflash.com.com',
                                                            linkDesc: _currentOrders?[
                                                                        index]
                                                                    .serviceName ??
                                                                'Page Not Found!',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ));
                                    }),
                                  ),
                                ),
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
