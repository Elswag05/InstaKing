import 'dart:core';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/services/notification.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/controllers/subscribe_cable_controller.dart';
import 'package:insta_king/presentation/views/bill_payment/bottom_sheet_modal.dart';
import 'package:insta_king/presentation/views/home/home_card_widgets.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/bank_account_details/bank_account_details.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';

/// Feel free to use the code in your projects
/// but do not forget to give me the credits adding
/// my app (Flutter Animation Gallery) where you are gonna use it.
/// ---------------------------------->>>>>>>>>>>>>>>>>>>>>>>>

class BillCable extends ConsumerStatefulWidget {
  const BillCable({super.key});

  @override
  ConsumerState<BillCable> createState() => _BillCableState();
}

class _BillCableState extends ConsumerState<BillCable> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  late String network = '';
  late final cableDecData =
      ref.read(instaCableController).getCableDecoderModel.data;
  late final cablePlanData =
      ref.read(instaCableController).getCablePlanModel.data;
  @override
  void initState() {
    ref.read(instaCableController).toGetCableDecoderPlans();
    super.initState();
  }

  void showReusableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ReusableBottomSheet(
          getLength: ref
                  .read(instaCableController)
                  .getCableDecoderModel
                  .data
                  ?.length ??
              5,
          title: 'Choose Decoder Plan',
          status: 'initialStatus', // Set your initial status here
          onStatusChanged: (newStatus) {
            // Handle the status change here if needed
            debugPrint('New Status: $newStatus');
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
                  appBarTitle: "Subscribe TV",
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
                      child: const ChooseContainerFromDropDown(
                        headerText: "Decoder Typr",
                        hintText: "Choose Decoder Typr",
                      ),
                    ).afmPadding(
                      EdgeInsets.only(
                        bottom: 20.h,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showReusableBottomSheet(context);
                      },
                      child: const ChooseContainerFromDropDown(
                        headerText: "Decoder Plan",
                        hintText: "Choose Decoder Plan",
                      ),
                    ).afmPadding(
                      EdgeInsets.only(
                        bottom: 20.h,
                      ),
                    ),
                    Stack(
                      children: [
                        CollectPersonalDetailModel(
                          leadTitle: "Cable Number",
                          hintT: "XXXX XXX XXXX",
                          isPasswordT: false,
                          isdigit: [FilteringTextInputFormatter.digitsOnly],
                          numberOfTexts: 11,
                          controller: numberController,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    CollectPersonalDetailModel(
                      leadTitle: "Amount",
                      hintT: "₦5 000",
                      isPasswordT: false,
                      isdigit: [FilteringTextInputFormatter.digitsOnly],
                      controller: amountController,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    CustomButton(
                      pageCTA: "Proceed",
                      buttonOnPressed: () {
                        setState(() {});
                        ref
                            .read(instaCableController)
                            .tovalidateUserCableEligibiity("cableID", "number")
                            .then(
                          (value) {
                            if (value == true) {
                              ref
                                  .read(instaCableController)
                                  .toPurchaseCable("cablePlanID", "number",
                                      "cable", "customerName")
                                  .then((value) {
                                if (value == true) {
                                  // Handle success

                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.scale,
                                    dialogType: DialogType.success,
                                    title: 'Order Successful',
                                    desc:
                                        'You have successfully purchased this Cable Subscription',
                                    btnOkOnPress: () {
                                      Navigator.pop(context);
                                    },
                                  ).show();
                                  LocalNotification.showPurchaseNotification(
                                    title: 'InstaKing ♛ \nOrder Successful',
                                    body:
                                        'Dear ${ref.read(instaProfileController.notifier).model.user?.fullname},\nYour Cable purchase of ${formatBalance(
                                      amountController.text,
                                    )} is successful.\nYour available insta balance is ₦${ref.read(instaProfileController.notifier).model.user?.balance}.\nPurchase Details  ::: \nName: {selectedServiceName}\nCategory: Data Purchase\nAmount: ${formatBalance(amountController.text)}',
                                    payload: '',
                                  );
                                }
                              });
                            } else {
                              setState(() {
                                ref.read(instaCableController).loadingState ==
                                    LoadingState.idle;
                              });
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.error,
                                title: 'Order Failed',
                                desc: 'Your order could not be placed',
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
                        top: 40.sp,
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
            if (ref.read(instaCableController).loadingState ==
                LoadingState.loading)
              const TransparentLoadingScreen(),
          ],
        ),
      ),
    );
  }
}
