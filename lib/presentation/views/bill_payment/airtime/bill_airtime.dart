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
import 'package:insta_king/presentation/controllers/purchase_airtime_controller.dart';
import 'package:insta_king/presentation/controllers/text_editing_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/bottom_sheet_modal.dart';
import 'package:insta_king/presentation/views/bill_payment/common_widgets.dart';
import 'package:insta_king/presentation/views/home/home_card_widgets.dart';
import 'package:insta_king/presentation/views/shared_widgets/choose_container.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';

/// Feel free to use the code in your projects
/// but do not forget to give me the credits adding
/// my app (Flutter Animation Gallery) where you are gonna use it.
/// ---------------------------------->>>>>>>>>>>>>>>>>>>>>>>>

class BillAirtime extends ConsumerStatefulWidget {
  const BillAirtime({super.key});

  @override
  ConsumerState<BillAirtime> createState() => _BillAirtimeState();
}

class _BillAirtimeState extends ConsumerState<BillAirtime> {
  late final TextEditingController amountController;
  late TextValueNotifier textValueNotifier;
  late String networkID = '';
  late String networkName = '';
  late final networkPr = ref.read(instaAirtimeController).getNetworkModel.data;
  @override
  void initState() {
    textValueNotifier = ref.read(textValueProvider);
    ref.read(instaAirtimeController).toGetNetworks();
    amountController = TextEditingController();
    super.initState();
  }

  void showReusableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ReusableBottomSheet(
          getLength:
              ref.read(instaAirtimeController).getNetworkModel.data?.length ??
                  5,
          title: 'Choose Network',
          status: 'initialStatus', // Set your initial status here
          networkPr: ref.read(instaAirtimeController).getNetworkModel.data,
          onStatusChanged: (newStatus, netName) {
            // Handle the status change here if needed
            setState(() {
              networkID = newStatus?[netName].id.toString() ?? '';
              networkName = newStatus?[netName].name.toString() ?? '';
            });
            debugPrint(
                'New Status: $newStatus and $networkID, Think Network name? $networkName');
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
                  appBarTitle: "Purchase Airtime",
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
                        headerText: "Network",
                        hintText:
                            networkName != '' ? networkName : "Choose Network",
                      ),
                    ),
                    // .afmPadding(
                    //   EdgeInsets.only(
                    //     bottom: 10.h,
                    //   ),
                    // ),
                    CollectPersonalDetailModel(
                      leadTitle: "Phone Number",
                      hintT: "080 XXX XXXX",
                      isPasswordT: false,
                      isdigit: [FilteringTextInputFormatter.digitsOnly],
                      //  numberOfTexts: 11,
                      controller: ref.read(textControllerProvider),
                      onChanged: (value) {
                        textValueNotifier.airtimeTextValue = value;
                        setState(() {});
                      },
                    ),
                    CollectPersonalDetailModel(
                      leadTitle: "Amount",
                      hintT: "₦500",
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
                            .read(instaAirtimeController)
                            .toPurchaseAirtime(
                              networkID,
                              textValueNotifier.airtimeTextValue,
                              stringToNum(amountController.text),
                            )
                            .then(
                          (value) {
                            if (value == true) {
                              // Handle success

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
                                title: 'Order Successful',
                                body:
                                    'Dear ${ref.read(instaProfileController.notifier).model.user?.fullname},\nYour purchase of ${formatBalance(stringToNum(amountController.text).toString())} is successful.\nYour new balance is ₦${ref.read(instaProfileController.notifier).model.user?.balance}.',
                                payload: '',
                              );
                            } else {
                              // Handle failure or other cases
                              // Optionally, you can show an error message or take appropriate action
                              setState(() {
                                ref.read(instaAirtimeController).loadingState ==
                                    LoadingState.idle;
                              });
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.error,
                                title: 'Order Failed',
                                desc: 'This order could not be placed',
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
            if (ref.read(instaAirtimeController).loadingState ==
                LoadingState.loading)
              const TransparentLoadingScreen(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}
