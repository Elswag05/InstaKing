import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_wallet_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/wallet/add_funds/account_details.dart';

class WalletCard1 extends StatefulWidget {
  const WalletCard1({Key? key}) : super(key: key);

  @override
  State<WalletCard1> createState() => _WalletCard1State();
}

class _WalletCard1State extends State<WalletCard1> {
  late bool onGenerate;

  @override
  void initState() {
    onGenerate = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return onGenerate
        ? Consumer(
            builder: (context, ref, child) {
              final generatedAccounts =
                  ref.read(instaWalletController.notifier);
              return Container(
                color: Theme.of(context).cardColor,
                // width: MediaQuery.of(context).size.width - 40.sp,
                height: 370.h,
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
                    Expanded(
                      child: Column(
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
                          SizedBox(
                              width: double.maxFinite,
                              child: FutureBuilder(
                                future:
                                    generatedAccounts.generateAccountDetails(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return ListView.builder(
                                      itemCount:
                                          generatedAccounts.model.data!.length,
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
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              )),
                        ],
                      ),
                    ),
                    //TODO: Implement Backend here

                    // const AccountDetails(
                    //   accountName: 'John Doe',
                    // ),
                    // const AccountDetails(
                    //   accountName: 'John Doe',
                    //   bankName: 'Sterling Bank',
                    // ),
                    // const AccountDetails(
                    //   accountName: 'John Doe',
                    //   bankName: 'Moniepoint MFB',
                    // ),
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
            },
          )
        : Consumer(
            builder: ((context, ref, child) {
              final general = ref.read(instaWalletController.notifier);
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
                        general.generateAccountDetails();
                        setState(() {
                          onGenerate = true;
                        });
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
            }),
          );
  }
}
