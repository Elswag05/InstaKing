import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/controllers/insta_wallet_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'package:insta_king/presentation/views/wallet/add_funds/account_details.dart';
import 'package:lottie/lottie.dart';

class WalletCard1 extends ConsumerStatefulWidget {
  const WalletCard1({super.key});

  @override
  ConsumerState<WalletCard1> createState() => _WalletCard1State();
}

class _WalletCard1State extends ConsumerState<WalletCard1>
    with SingleTickerProviderStateMixin {
  late final generatedAccounts = ref.watch(instaWalletController);
  late final AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await generatedAccounts
        .checkUserAccounts(ref.read(instaProfileController).model);
    _controller.dispose();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: generatedAccounts.checkUserAccounts(
            ref.read(instaProfileController.notifier).model.user?.virtualBanks),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (generatedAccounts.userHasGeneratedAccount ||
                generatedAccounts.accountIsGen) {
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
                    Column(
                      children: [
                        Text(
                          'Make transfer into the account number below to fund your wallet automatically',
                          style: TextStyle(
                            fontFamily: 'Montesserat',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ).afmPadding(
                          EdgeInsets.only(
                            bottom: 10.sp,
                          ),
                        ),
                        (generatedAccounts.model.data?.isNotEmpty ??
                                generatedAccounts.accountIsGen)
                            ? SizedBox(
                                width:
                                    MediaQuery.of(context).size.width - 40.sp,
                                height: 240.h,
                                child: ListView.builder(
                                  itemCount:
                                      generatedAccounts.model.data?.length,
                                  itemBuilder: (((context, index) {
                                    return AccountDetails(
                                      accountName: generatedAccounts
                                              .model.data?[index].accountName ??
                                          'Loading...',
                                      bankName: generatedAccounts
                                              .model.data?[index].bankName ??
                                          'Loading...',
                                      accountNumber: generatedAccounts.model
                                              .data?[index].accountNumber ??
                                          'Loading...',
                                    );
                                  })),
                                ),
                              )
                            : Lottie.asset(
                                "assets/animation/null-animation.json",
                                controller: _controller,
                                onLoaded: (composition) {
                                  _controller
                                    ..duration = composition.duration
                                    ..repeat();
                                },
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
                    ),
                    CustomButton(
                      pageCTA: 'Generate Accounts',
                      toSignOrLogin: () async {
                        await generatedAccounts.generateAccountDetails();
                        setState(() {});
                      },
                    ),
                  ],
                ).afmPadding(
                  EdgeInsets.all(20.sp),
                ),
              )
                  .afmPadding(
                    EdgeInsets.only(bottom: 20.sp, left: 20.sp, right: 20.sp),
                  )
                  .afmBorderRadius(
                    BorderRadius.circular(10.r),
                  );
            }
          } else {
            return const TransparentLoadingScreen();
          }
        }));
  }
}
