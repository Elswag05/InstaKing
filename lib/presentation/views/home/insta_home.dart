import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_assets.dart';
import 'package:insta_king/data/controllers/insta_categories_controller.dart';
import 'package:insta_king/data/controllers/insta_order_controller.dart';
import 'package:insta_king/data/controllers/insta_wallet_controller.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/refer_and_earn/refer_and_earn.dart';
import 'package:insta_king/presentation/views/wallet/kyc.dart';
import 'package:lottie/lottie.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/controllers/insta_dashboard_controller.dart';
import 'package:insta_king/data/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/views/home/home_card_widgets.dart';
import 'package:insta_king/presentation/views/home/home_container_widget.dart';
import 'package:insta_king/presentation/views/home/home_head.dart';
import 'package:insta_king/presentation/views/home/home_shortcut_widgets.dart';

//Todo: release the changes i.e The locks on the shortcut icon on click, and the dashboard icon then the number arrangement

class InstaHome extends ConsumerStatefulWidget {
  const InstaHome({
    super.key,
  });

  @override
  ConsumerState<InstaHome> createState() => _InstaHomeState();
}

class _InstaHomeState extends ConsumerState<InstaHome>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool hasFetchedDetails = false;
  bool toCallWallet = false;
  bool toRemoveBvnInputCard = false;
  late bool userHasBvn;

  @override
  void initState() {
    super.initState();
    userHasBvn = (ref.read(instaWalletController).userHasGeneratedAccount ||
        ref.read(instaWalletController).accountIsGen);
    ref.read(instaProfileController.notifier).getProfileDetails().then((value) {
      setState(() {});
      hasFetchedDetails = true;
      ref.read(instaOrderController).toGetAllOrders();
    });
    ref.read(instaWalletController).checkUserAccounts(
          ref.read(instaProfileController.notifier).model.user?.virtualBanks,
        );
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(builder: (context, ref, child) {
          void setPageIndexToTwo(int numberHere) {
            final value = ref.read(dashBoardControllerProvider);
            value.switchPage(numberHere);
          }

          if (!hasFetchedDetails) {}
          return RefreshIndicator(
            onRefresh: () async {
              // Future.delayed(Duration.zero, () async {
              // });
              ref.read(instaCategoriesController.notifier).toGetAllCategories;
              ref
                  .read(instaProfileController.notifier)
                  .getProfileDetails()
                  .then((value) {
                setState(() {});
                hasFetchedDetails = true;
              });
              // setState(() {
              //   hasFetchedDetails = false;
              // });
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HomeHeaderWidget(
                    //imageFile: ref.watch(instaProfileController.notifier).image!,
                    url: ref
                            .read(instaProfileController.notifier)
                            .model
                            .user
                            ?.image ??
                        '',
                    username: ref
                            .read(instaProfileController.notifier)
                            .model
                            .user
                            ?.username ??
                        'User',
                    onNotificationsTap: () {},
                    isHomeImageNull:
                        ref.watch(instaProfileController).model.user?.image ==
                                null
                            ? true
                            : false,
                    foregroundImageUrl: ref
                        .watch(instaProfileController)
                        .model
                        .user
                        ?.profilePicture,
                    onProfileTap: () {
                      setPageIndexToTwo(4);
                      setState(() {});
                    },
                  ).afmPadding(
                    EdgeInsets.only(
                        left: 20.sp, right: 20.sp, top: 5.sp, bottom: 20.h),
                  ),
                  HomeCardList(
                    totalBalance:
                        ref.read(instaProfileController).model.user?.balance ??
                            'Loading...',
                    totalBonus:
                        ref.read(instaProfileController).model.user?.bonus ??
                            'Loading...',
                    affiliateLink:
                        'https:/www.instaking.ng/signup?ref=${ref.read(instaProfileController.notifier).model.user?.username ?? "waiting..."}',
                  ),
                  //show bvn input field
                  (userHasBvn || toRemoveBvnInputCard)
                      ? const SizedBox()
                      : Badge(
                          offset: const Offset(-6, -1),
                          isLabelVisible: !toRemoveBvnInputCard,
                          label: GestureDetector(
                            onTap: () {
                              setState(() {
                                toRemoveBvnInputCard = true;
                              });
                            },
                            child: Icon(
                              Icons.close_rounded,
                              size: 14.sp,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const KYCForBVN(),
                              ));
                            },
                            child: HomeContainer(
                              color: Theme.of(context).cardColor,
                              height: 50.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    EnvAssets.getImagePath('warning'),
                                    width: 30.w,
                                    height: 30.h,
                                    fit: BoxFit.contain,
                                  ).afmPadding(
                                    EdgeInsets.only(right: 5.w),
                                  ),
                                  SizedBox(
                                    width: 250.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Virtual Account Update",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Montesserat',
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Your virtual account will be DISABLED on the 1st of July 2024 if you do not verify your information!",
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: 'Montesserat',
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                                .afmBorderRadius(BorderRadius.circular(15.r))
                                .afmPadding(EdgeInsets.only(bottom: 15.h)),
                          ),
                        ),
                  HomeContainer(
                    color: Theme.of(context).cardColor,
                    height: 170.h,
                    child: const ShortcutsTheWidget(),
                  )
                      .afmBorderRadius(BorderRadius.circular(24.r))
                      .afmPadding(EdgeInsets.only(bottom: 15.h)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ReferAndEarn(),
                        ),
                      );
                    },
                    child: Container(
                      height: 100.h,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 40.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: InstaColors.containerGradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: const [0, 0.2, 0.5, 0.8],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50.h,
                            width: 150.w,
                            child: Center(
                              child: Text(
                                'Refer people and earn up to 10% off all their transactions',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montesserat',
                                ),
                              ),
                            ),
                          ).afmPadding(
                            EdgeInsets.only(
                              // top: 10.h,
                              // bottom: 10.h,
                              left: 20.w,
                            ),
                          ),
                          SizedBox(
                            child: Lottie.asset(
                              "assets/animation/insta_refer.json",
                              controller: _controller,
                              onLoaded: (composition) {
                                _controller
                                  ..duration = composition.duration
                                  ..forward();
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                        .afmBorderRadius(BorderRadius.circular(24.r))
                        .afmPadding(EdgeInsets.only(bottom: 50.h)),
                  ),
                ],
              ).afmPadding(
                EdgeInsets.only(top: 10.h),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

//                 Stack(
//                   children: [
//                     HomeContainer(
//                             color: Theme.of(context).cardColor,
//                             height: 360.h,
//                             child: FutureBuilder(
//                               future: ref
//                                   .read(instaTransactionController.notifier)
//                                   .getTransactions(),
//                               builder: (context, snapshot) {
//                                 if (snapshot.connectionState ==
//                                     ConnectionState.done) {
//                                   return ListView.builder(
//                                     padding: EdgeInsets.only(
//                                         top: 40.h,
//                                         left: 23.h,
//                                         right: 20.h,
//                                         bottom: 20.h),
//                                     itemCount: 5,
//                                     itemBuilder: ((context, index) {
//                                       final trx = ref
//                                           .watch(instaTransactionController)
//                                           .instaTransactionsModel;
//                                       final transaction = trx
//                                           .data?.transactions[index.toString()];
//                                       return OrderHistoryViewModel(
//                                         idText: '${transaction?.id}',
//                                         dateHere: '${transaction?.createdAt}',
//                                         linkHere: '${transaction?.updatedAt}',
//                                         priceHere: '${transaction?.charge}',
//                                         digitHere: '${transaction?.amount}',
//                                         quantity: '${transaction?.response}',
//                                         serviceHere: '${transaction?.service}',
//                                         remNant: '${transaction?.oldBalance}',
//                                         status: SizedBox(),
//                                       );
//                                     }),
//                                   );
//                                 } else {
//                                   return const TransparentLoadingScreen();
//                                 }

// // ...
//                               },
//                             ))
//                         .afmBorderRadius(BorderRadius.circular(24.r))
//                         .afmPadding(EdgeInsets.only(bottom: 20.h)),
//                     Container(
//                       height: 40.h,
//                       width: MediaQuery.of(context).size.width - 40.sp,
//                       padding: EdgeInsets.only(left: 25.sp, top: 15.sp),
//                       color: Theme.of(context).colorScheme.onSurfaceVariant,
//                       child: Text(
//                         'Recent Transactions',
//                         style: TextStyle(
//                           fontFamily: 'Montesserat',
//                           fontSize: 15.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ).afmBorderRadius(BorderRadius.only(
//                         topLeft: Radius.circular(24.r),
//                         topRight: Radius.circular(24.r))),
//                   ],
//                 ),
