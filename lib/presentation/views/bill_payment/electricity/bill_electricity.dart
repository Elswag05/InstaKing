import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/data/services/notification.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/controllers/purchase_data_controller.dart';
import 'package:insta_king/presentation/controllers/purchase_electricity_controller.dart';
import 'package:insta_king/presentation/views/home/home_card_widgets.dart';
import 'package:insta_king/presentation/views/shared_widgets/bottom_sheet_modal.dart';
import 'package:insta_king/presentation/views/shared_widgets/choose_container.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'package:insta_king/utils/locator.dart';

/// Feel free to use the code in your projects
/// but do not forget to give me the credits adding
/// my app (Flutter Animation Gallery) where you are gonna use it.
/// ---------------------------------->>>>>>>>>>>>>>>>>>>>>>>>
///
class Network {
  String name;

  Network(this.name);
}

List<dynamic> networkData = [
  Network('Prepaid'),
  Network('Postpaid'),
];

class BillElectricity extends ConsumerStatefulWidget {
  const BillElectricity({super.key});

  @override
  ConsumerState<BillElectricity> createState() => _BillElectricityState();
}

class _BillElectricityState extends ConsumerState<BillElectricity> {
  late final TextEditingController amountController;
  late final TextEditingController meterNumberController;
  late String discoName = '';
  late num discoId = 0;
  late String meterType = '';
  late String customerName = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late bool userHasPickedDisco = false;
  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    meterNumberController = TextEditingController();
    ref.read(instaElectricityController).toGetPowerPlans();
  }

  void showReusableBottomSheet(BuildContext context, dataList, func) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: ref
              .read(instaElectricityController)
              .toGetPowerPlans()
              .then((value) {
            setState(() {});
          }),
          builder: (context, snapshot) {
            return ReusableBottomSheet(
              future: ref
                  .read(instaElectricityController)
                  .toGetPowerPlans()
                  .then((value) {
                setState(() {});
              }),
              getLength: dataList?.length ?? 5,
              title: 'Choose Disco Name',
              networkPr: dataList,
              status: 'initialStatus', // Set your initial status here
              onStatusChanged: func,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                        showReusableBottomSheet(
                          context,
                          ref
                              .read(instaElectricityController)
                              .getPowerPlanModel
                              .data,
                          (newStatus, val) {
                            // Handle the status change here if needed
                            setState(() {
                              meterType = '';
                              discoName = newStatus?[val].name ?? '';
                              discoId = newStatus?[val].id ?? 0;
                            });
                            debugPrint('New Status: $discoId && $discoName');
                          },
                        );
                      },
                      child: ChooseContainerFromDropDown(
                        headerText: "Disco Name",
                        hintText: discoName != '' ? discoName : "Select type",
                      ),
                    ),
                    // .afmPadding(
                    //   EdgeInsets.only(
                    //     bottom: 20.h,
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        showReusableBottomSheet(
                          context,
                          networkData,
                          (newStatus, val) {
                            // Handle the status change here if needed
                            setState(() {
                              meterType = newStatus?[val].name ?? '';
                            });
                            debugPrint('New Meter Type: $meterType');
                          },
                        );
                      },
                      child: ChooseContainerFromDropDown(
                        headerText: "Meter Type",
                        hintText:
                            meterType != '' ? meterType : "Select meter type",
                      ),
                    ),
                    // .afmPadding(
                    //   EdgeInsets.only(
                    //     bottom: 20.h,
                    //   ),
                    // ),
                    CollectPersonalDetailModel(
                      leadTitle: "Meter Number",
                      hintT: "XXXX-XXX-XXXX",
                      isPasswordT: false,
                      isdigit: [FilteringTextInputFormatter.digitsOnly],
                      controller: meterNumberController,
                      textInputType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    CollectPersonalDetailModel(
                      leadTitle: "Amount",
                      hintT: "₦1 000",
                      isPasswordT: false,
                      isdigit: [FilteringTextInputFormatter.digitsOnly],
                      textInputType: TextInputType.number,
                      controller: amountController,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    CustomButton(
                      pageCTA: "Validate",
                      buttonOnPressed: () {
                        setState(() {});
                        ref
                            .read(instaElectricityController)
                            .tovalidateUserEligibiity(
                              discoId,
                              meterType.toLowerCase(),
                              meterNumberController.text,
                            )
                            .then((value) {
                          if (value == true) {
                            setState(() {});
                            void showAlert(BuildContext context) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    "Pay Electricity Bills",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Montesserat',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        EnvAssets.getImagePath(
                                          'checkmark',
                                        ),
                                        color: InstaColors.successColor,
                                        width: 18.w,
                                        height: 18.h,
                                      ).afmPadding(
                                        EdgeInsets.only(right: 5.w),
                                      ),
                                      Text(
                                        ref
                                            .read(instaElectricityController
                                                .notifier)
                                            .userName,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Montesserat',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: InstaColors.successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actionsAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  actions: [
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          InstaColors.primaryColor,
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                          const EdgeInsets.all(
                                            16.0,
                                          ),
                                        ),
                                        minimumSize:
                                            MaterialStateProperty.all<Size>(
                                          Size(
                                            250.w,
                                            30.h,
                                          ), // Set the minimum width and height
                                        ),
                                        textStyle: MaterialStateProperty.all<
                                            TextStyle>(
                                          const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        // 'Proceed' button pressed - do nothing
                                        Navigator.pop(context);
                                        setState(() {});
                                        ref
                                            .read(instaElectricityController)
                                            .toPurchaseElectricity(
                                              discoId,
                                              meterNumberController.text,
                                              meterType.toLowerCase(),
                                              int.tryParse(
                                                      amountController.text) ??
                                                  500,
                                              ref
                                                  .read(
                                                      instaElectricityController)
                                                  .userName,
                                            )
                                            .then((value) {
                                          if (value == true) {
                                            // Handle success
                                            setState(() {});
                                            AwesomeDialog(
                                                context: _scaffoldKey
                                                        .currentContext ??
                                                    context,
                                                animType: AnimType.scale,
                                                dialogType: DialogType.success,
                                                title: 'Order Successful',
                                                desc: ref
                                                    .read(
                                                        instaElectricityController)
                                                    .message,
                                                btnOkOnPress: () {
                                                  Navigator.pop(context);
                                                },
                                                onDismissCallback: (type) {
                                                  Navigator.of(_scaffoldKey
                                                          .currentContext!)
                                                      .pop();
                                                },
                                                btnCancelText: 'Copy Token',
                                                btnCancelOnPress: () {
                                                  Clipboard.setData(
                                                    ClipboardData(
                                                      text:
                                                          "Token: ${ref.watch(instaElectricityController).newToken}",
                                                    ),
                                                  );
                                                  locator<ToastService>()
                                                      .showSuccessToast(
                                                    'You have copied your order ID',
                                                  );
                                                }).show();
                                            LocalNotification
                                                .showPurchaseNotification(
                                              title: 'Order Successful',
                                              body:
                                                  'Dear ${ref.read(instaProfileController.notifier).model.user?.fullname},\nYour purchase of ${formatBalance(
                                                amountController.text,
                                              )} is successful.\nYour new balance is ₦${ref.read(instaProfileController.notifier).model.user?.balance}.}',
                                              payload: '',
                                            );
                                          } else {
                                            setState(() {});
                                            AwesomeDialog(
                                              context:
                                                  _scaffoldKey.currentContext ??
                                                      context,
                                              animType: AnimType.scale,
                                              dialogType: DialogType.error,
                                              title: 'Order Failed',
                                              desc:
                                                  'Your order could not be placed',
                                              onDismissCallback: (type) {
                                                Navigator.of(_scaffoldKey
                                                        .currentContext!)
                                                    .pop();
                                              },
                                              btnOkOnPress: () {
                                                Navigator.pop(context);
                                              },
                                            ).show();
                                          }
                                        });
                                      },
                                      child: Text(
                                        "Proceed",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Montesserat',
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            showAlert(context);
                          } else {
                            setState(() {
                              ref.read(instaDataController).loadingState ==
                                  LoadingState.idle;
                            });
                            AwesomeDialog(
                              context: _scaffoldKey.currentContext ?? context,
                              animType: AnimType.scale,
                              dialogType: DialogType.error,
                              title: 'Order Failed',
                              desc: 'Your order could not be placed',
                              onDismissCallback: (type) {
                                Navigator.of(_scaffoldKey.currentContext!)
                                    .pop();
                              },
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                            ).show();
                          }
                        });
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
            if (ref.read(instaElectricityController).loadingState ==
                LoadingState.loading)
              const TransparentLoadingScreen(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    meterNumberController.dispose();
    amountController.dispose();
    super.dispose();
  }
}
