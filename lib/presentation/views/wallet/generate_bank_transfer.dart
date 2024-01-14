import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/controllers/insta_wallet_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'package:insta_king/presentation/views/wallet/add_funds/account_details.dart';

class WalletCard1 extends ConsumerStatefulWidget {
  const WalletCard1({super.key});

  @override
  ConsumerState<WalletCard1> createState() => _WalletCard1State();
}

class _WalletCard1State extends ConsumerState<WalletCard1>
    with SingleTickerProviderStateMixin {
  late ProfileController generatedAccounts;
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    generatedAccounts = ref.read(instaProfileController);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    //generatedAccounts.dispose();
    super.dispose();
  }

  double calculateListViewHeight(int itemCount, double itemHeight) {
    return itemCount * itemHeight;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ref.read(instaWalletController).checkUserAccounts(
              ref
                  .read(instaProfileController.notifier)
                  .model
                  .user
                  ?.virtualBanks,
            ),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (ref.read(instaWalletController).userHasGeneratedAccount ||
                ref.read(instaWalletController).accountIsGen) {
              return Container(
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bank Transfer',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ).afmPadding(
                      EdgeInsets.only(
                        bottom: 20.sp,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          'Make transfer into the account number below to fund your wallet automatically',
                          style: TextStyle(
                            fontFamily: 'Montesserat',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ).afmPadding(
                          EdgeInsets.only(
                            bottom: 10.sp,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40.sp,
                          height: calculateListViewHeight(
                              ref
                                      .read(instaProfileController)
                                      .model
                                      .user
                                      ?.virtualBanks
                                      ?.length ??
                                  2,
                              120.h),
                          child: AnimationLimiter(
                            child: ListView.builder(
                              itemCount: ref
                                  .read(instaProfileController)
                                  .model
                                  .user
                                  ?.virtualBanks
                                  ?.length,
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              itemBuilder: ((context, index) {
                                return AccountDetails(
                                  accountName: ref
                                          .read(instaProfileController)
                                          .model
                                          .user
                                          ?.virtualBanks?[index]
                                          .accountName ??
                                      'Loading...',
                                  bankName: ref
                                          .read(instaProfileController)
                                          .model
                                          .user
                                          ?.virtualBanks?[index]
                                          .bankName ??
                                      'Loading...',
                                  accountNumber: ref
                                          .read(instaProfileController)
                                          .model
                                          .user
                                          ?.virtualBanks?[index]
                                          .accountNumber ??
                                      'Loading...',
                                );
                              }),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ).afmPadding(
                  EdgeInsets.all(20.sp),
                ),
              )
                  .afmBorderRadius(
                    BorderRadius.circular(10.r),
                  )
                  .afmPadding(
                    EdgeInsets.only(bottom: 20.sp, left: 20.sp, right: 20.sp),
                  );
            } else {
              return Container(
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bank Transfer',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ).afmPadding(
                      EdgeInsets.only(
                        bottom: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            Icons.warning_amber_outlined,
                            color: InstaColors.errorColor,
                            size: 13.sp,
                          ),
                          SizedBox(
                            height: 30.h,
                            width: MediaQuery.of(context).size.width - 100.w,
                            child: Text(
                              'You have not been assigned an account yet!',
                              style: TextStyle(
                                fontFamily: 'Montesserat',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          )
                        ],
                      ),
                    ).afmPadding(
                      EdgeInsets.only(bottom: 10.h),
                    ),
                    CustomButton(
                      pageCTA: 'Generate Accounts',
                      buttonOnPressed: () async {
                        await ref
                            .read(instaWalletController)
                            .generateAccountDetails()
                            .then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  ],
                ).afmPadding(
                  EdgeInsets.all(20.sp),
                ),
              )
                  .afmBorderRadius(
                    BorderRadius.circular(10.r),
                  )
                  .afmPadding(
                    EdgeInsets.only(bottom: 20.sp, left: 20.sp, right: 20.sp),
                  );
            }
          } else {
            return const TransparentLoadingScreen();
          }
        }));
  }
}
