import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/services/notification.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/controllers/purchase_airtime_controller.dart';
import 'package:insta_king/presentation/controllers/purchase_data_controller.dart';
import 'package:insta_king/presentation/controllers/text_editing_controller.dart';
import 'package:insta_king/presentation/views/bill_payment/airtime/airtime_widgets.dart';
import 'package:insta_king/presentation/views/bill_payment/bottom_sheet_modal.dart';
import 'package:insta_king/presentation/views/bill_payment/common_widgets.dart';
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

class BillData extends ConsumerStatefulWidget {
  const BillData({super.key});

  @override
  ConsumerState<BillData> createState() => _BillDataState();
}

class _BillDataState extends ConsumerState<BillData> {
  final TextEditingController amountController = TextEditingController();
  late TextValueNotifier textValueNotifier = ref.read(textValueProvider);
  late bool userHasPickedNetwork = false;
  @override
  void initState() {
    textValueNotifier = ref.read(textValueProvider);
    ref.read(instaAirtimeController).toGetNetworks();
    super.initState();
  }

  void showReusableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ReusableBottomSheet(
          getLength:
              (ref.read(instaDataController).getDataPlanModel.data?.length ??
                  5),
          title: 'Choose Network',
          networkPr: [],
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
                  appBarTitle: "Buy Data",
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
                        headerText: "Network",
                        hintText: "Choose Network",
                      ).afmPadding(
                        EdgeInsets.only(
                          bottom: 20.h,
                        ),
                      ),
                    ),
                    userHasPickedNetwork
                        ? GestureDetector(
                            onTap: () {
                              showReusableBottomSheet(context);
                            },
                            child: const ChooseContainerFromDropDown(
                              headerText: "Data Bundle",
                              hintText: "Choose Data Plan",
                            ),
                          ).afmPadding(
                            EdgeInsets.only(
                              bottom: 20.h,
                            ),
                          )
                        : const SizedBox(),
                    Stack(
                      children: [
                        CollectPersonalDetailModel(
                          leadTitle: "Phone Number",
                          hintT: "080 XXX XXXX",
                          isPasswordT: false,
                          isdigit: [FilteringTextInputFormatter.digitsOnly],
                          numberOfTexts: 11,
                          controller: ref.read(textControllerProvider),
                          onChanged: (value) {
                            textValueNotifier.textValue = value;
                            setState(() {});
                          },
                        ),
                        Positioned(
                          bottom: 10.h,
                          left: 10.w,
                          child: Text(
                            'Network: ${getNetworkProvider(ref.watch(textValueProvider).airtimeTextValue)}',
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // CollectPersonalDetailModel(
                    //   leadTitle: "Amount",
                    //   hintT: "₦500",
                    //   isPasswordT: false,
                    //   isdigit: [FilteringTextInputFormatter.digitsOnly],
                    //   controller: amountController,
                    //   onChanged: (value) {
                    //     setState(() {});
                    //   },
                    // ),
                    CustomButton(
                      pageCTA: "Proceed",
                      buttonOnPressed: () {
                        setState(() {});
                        ref
                            .read(instaDataController)
                            .toBuyData(
                              "MTN",
                              "08134094579",
                              "",
                              "",
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
                                //TODO:catgory should be added here
                                title: 'InstaKing ♛ \nOrder Successful',
                                body:
                                    'Dear ${ref.read(instaProfileController.notifier).model.user?.fullname},\nYour data purchase of ${formatBalance(
                                  amountController.text,
                                )} is successful.\nYour available insta balance is ₦${ref.read(instaProfileController.notifier).model.user?.balance}.\nPurchase Details  ::: \nName: {selectedServiceName}\nCategory: Data Purchase\nAmount: ${formatBalance(amountController.text)}',
                                payload: '',
                              );
                            } else {
                              // Handle failure or other cases
                              // Optionally, you can show an error message or take appropriate action
                              setState(() {
                                ref.read(instaDataController).loadingState ==
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
            if (ref.read(instaDataController).loadingState ==
                LoadingState.loading)
              const TransparentLoadingScreen(),
          ],
        ),
      ),
    );
  }
}
