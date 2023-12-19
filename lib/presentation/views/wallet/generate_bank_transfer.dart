import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_wallet_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'package:insta_king/presentation/views/wallet/add_funds/account_details.dart';

class WalletCard1 extends ConsumerStatefulWidget {
  const WalletCard1({Key? key}) : super(key: key);

  @override
  ConsumerState<WalletCard1> createState() => _WalletCard1State();
}

class _WalletCard1State extends ConsumerState<WalletCard1> {
  late final generatedAccounts = ref.watch(instaWalletController);
  // late bool onGenerate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //   generatedAccounts.checkUserAccountTrue();
    return FutureBuilder(
        future: generatedAccounts.checkUserAccountTrue(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (generatedAccounts.userHasGeneratedAccount) {
              return Consumer(
                builder: (context, ref, child) {
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
                            // Add the bank account details widgets here
                            FutureBuilder(
                              future:
                                  generatedAccounts.generateAccountDetails(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        40.sp,
                                    height: 240.h,
                                    child: ListView.builder(
                                      itemCount: generatedAccounts
                                              .model.data?.length ??
                                          2,
                                      shrinkWrap: true,
                                      itemBuilder: (((context, index) {
                                        return AccountDetails(
                                          accountName: generatedAccounts.model
                                                  .data![index].accountName ??
                                              'Loading...',
                                          bankName: generatedAccounts.model
                                                  .data![index].bankName ??
                                              'Loading...',
                                          accountNumber: generatedAccounts.model
                                                  .data![index].accountNumber ??
                                              'Loading...',
                                        );
                                      })),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: TransparentLoadingScreen());
                                }
                              },
                            ),
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
                        EdgeInsets.only(
                            bottom: 20.sp, left: 20.sp, right: 20.sp),
                      );
                },
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
                      toSignOrLogin: () {
                        generatedAccounts.generateAccountDetails();
                        // setState(() {
                        //   onGenerate = true;
                        // });
                      },
                    )
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
        });
  }
}
