import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/services/notification.dart';
import 'package:insta_king/data/controllers/insta_profile_controller.dart';
import 'package:insta_king/data/controllers/insta_wallet_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/bottom_sheet_modal.dart';
import 'package:insta_king/presentation/views/shared_widgets/choose_container.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';

class KYCForBVN extends ConsumerStatefulWidget {
  const KYCForBVN({super.key});

  @override
  ConsumerState<KYCForBVN> createState() => _KYCForBVNState();
}

class _KYCForBVNState extends ConsumerState<KYCForBVN> {
  @override
  void initState() {
    super.initState();
    myAccountNumber = TextEditingController();
    BVNNumber = TextEditingController();
    Future(() {
      ref.watch(instaWalletController.notifier).toGetUserBanks();
    });
  }

  String bankName = '';
  String bankCode = '';
  late TextEditingController myAccountNumber;
  // ignore: non_constant_identifier_names
  late TextEditingController BVNNumber;
  void showReusableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        debugPrint('Starting bottomSheet computation');
        return ReusableBottomSheet(
          future: ref.read(instaWalletController).toGetUserBanks(),
          getLength:
              ref.read(instaWalletController).getBanksModel.data?.length ?? 5,
          title: 'Choose Bank',
          status: 'initialStatus', // Set your initial status here
          networkPr: ref.read(instaWalletController).getBanksModel.data,
          onStatusChanged: (newStatus, netName) {
            // Handle the status change here if needed

            setState(() {
              bankCode = newStatus?[netName].code.toString() ?? '';
              bankName = newStatus?[netName].name.toString() ?? '';
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const RecurringAppBar(
                  appBarTitle: "Verify KYC",
                ).afmPadding(
                  EdgeInsets.only(
                    bottom: 10.h,
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showReusableBottomSheet(context);
                      },
                      child: ChooseContainerFromDropDown(
                        headerText: "Bank",
                        hintText: bankName != '' ? bankName : "Choose Bank",
                      ),
                    ),
                    CollectPersonalDetailModel(
                      leadTitle: "Account Number",
                      hintT: "XXX XXX XXXX",
                      isPasswordT: false,
                      isdigit: [FilteringTextInputFormatter.digitsOnly],
                      //  numberOfTexts: 11,
                      textInputType: TextInputType.number,
                      controller: myAccountNumber,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    CollectPersonalDetailModel(
                      leadTitle: "BVN",
                      hintT: "XXX XXX XXXX",
                      isPasswordT: false,
                      isdigit: [FilteringTextInputFormatter.digitsOnly],
                      //  numberOfTexts: 11,
                      textInputType: TextInputType.number,
                      controller: BVNNumber,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    CustomButton(
                      pageCTA: "Proceed",
                      buttonOnPressed: () {
                        setState(() {});
                        ref
                            .read(instaWalletController)
                            .toVerifyKYC(
                              BVNNumber.text,
                              bankCode,
                              myAccountNumber.text,
                            )
                            .then(
                          (value) {
                            if (value == true) {
                              () async {
                                await ref
                                    .read(instaWalletController)
                                    .generateAccountDetails()
                                    .then((value) {
                                  setState(() {});
                                });
                              };
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.success,
                                title: 'Order Successful',
                                desc:
                                    'You have successfully purchased this data',
                                btnOkOnPress: () {
                                  Navigator.pop(context);
                                },
                              ).show();
                              LocalNotification.showPurchaseNotification(
                                title: 'KYC Successful',
                                body:
                                    'Dear ${ref.read(instaProfileController.notifier).model.user?.fullname},\nYour KYC status update is successful.\nYour are now a verified user.',
                                payload: '',
                              );
                            } else {
                              setState(() {});
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.error,
                                title: 'KYC Failed',
                                desc:
                                    'Sorry your request could not be processed! Try again later',
                                btnOkOnPress: () {
                                  Navigator.pop(context);
                                },
                              ).show();
                            }
                          },
                        );
                      },
                    ).afmPadding(
                      EdgeInsets.only(
                        top: 20.sp,
                      ),
                    ),
                  ],
                ).afmPadding(
                  EdgeInsets.symmetric(
                    horizontal: 20.sp,
                  ),
                ),
              ],
            ).afmNeverScroll,
            if (ref.read(instaWalletController).loadingState ==
                LoadingState.loading)
              const TransparentLoadingScreen(),
          ],
        ),
      ),
    );
  }
}
