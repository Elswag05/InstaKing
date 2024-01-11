import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/services/notification.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/controllers/purchase_data_controller.dart';
import 'package:insta_king/presentation/controllers/purchase_electricity_controller.dart';
import 'package:insta_king/presentation/controllers/text_editing_controller.dart';
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

class BillElectricity extends ConsumerStatefulWidget {
  const BillElectricity({super.key});

  @override
  ConsumerState<BillElectricity> createState() => _BillElectricityState();
}

class _BillElectricityState extends ConsumerState<BillElectricity> {
  final TextEditingController amountController = TextEditingController();
  late bool userHasPickedNetwork = false;
  @override
  void initState() {
    ref.read(instaElectricityController).toGetPowerPlans();
    super.initState();
  }

  void showReusableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ReusableBottomSheet(
          getLength:
              ref.read(instaDataController).getDataPlanModel.data?.length ?? 5,
          title: 'Choose Disco Type',
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
                  appBarTitle: "Pay Electricity Bills",
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
                        headerText: "Disco Name",
                        hintText: "Select type",
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
                        headerText: "Meter Type",
                        hintText: "Select meter type",
                      ),
                    ).afmPadding(
                      EdgeInsets.only(
                        bottom: 20.h,
                      ),
                    ),
                    CollectPersonalDetailModel(
                      leadTitle: "Meter Number",
                      hintT: "XXXX-XXX-XXXX",
                      isPasswordT: false,
                      isdigit: [FilteringTextInputFormatter.digitsOnly],
                      numberOfTexts: 11,
                      controller: ref.read(textControllerProvider),
                      onChanged: (value) {
                        setState(() {});
                      },
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
                            .read(instaElectricityController)
                            .tovalidateUserEligibiity(
                                "discoID", "meterType", "meterNumber")
                            .then((value) {
                          if (value == true) {
                            ref
                                .read(instaElectricityController)
                                .toPurchaseElectricity(
                                  "discoID",
                                  "number",
                                  "type",
                                  "amount",
                                  "customerName",
                                  "phone",
                                )
                                .then((value) {
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
                                  title: 'InstaKing ♛ \nOrder Successful',
                                  body:
                                      'Dear ${ref.read(instaProfileController.notifier).model.user?.fullname},\nYour Electricity purchase of ${formatBalance(
                                    amountController.text,
                                  )} is successful.\nYour available insta balance is ₦${ref.read(instaProfileController.notifier).model.user?.balance}.\nPurchase Details  ::: \nName: {selectedServiceName}\nCategory: Data Purchase\nAmount: ${formatBalance(amountController.text)}',
                                  payload: '',
                                );
                              }
                            });
                          } else {
                            setState(() {
                              ref.read(instaDataController).loadingState ==
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
                        });
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
            if (ref.read(instaElectricityController).loadingState ==
                LoadingState.loading)
              const TransparentLoadingScreen(),
          ],
        ),
      ),
    );
  }
}