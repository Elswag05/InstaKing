import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/core/constants/env_assets.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/controllers/bet_data_controller.dart';
import 'package:insta_king/data/controllers/insta_profile_controller.dart';
import 'package:insta_king/data/services/notification.dart';
import 'package:insta_king/presentation/views/home/home_card_widgets.dart';
import 'package:insta_king/presentation/views/shared_widgets/bottom_sheet_modal.dart';
import 'package:insta_king/presentation/views/shared_widgets/choose_container.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';

class BetBills extends ConsumerStatefulWidget {
  const BetBills({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BetBillsState();
}

class _BetBillsState extends ConsumerState<BetBills> {
  String betPlatform = '';
  int betPlatformId = 0;
  late final TextEditingController amountController;
  late final TextEditingController betAccountNumberController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late bool userHasPickedBetPlan = false;
  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    betAccountNumberController = TextEditingController();
    ref.read(instaBetController).toGetBetPlans();
  }

  void showReusableBottomSheet(BuildContext context, dataList, func) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: ref.read(instaBetController).toGetBetPlans().then((value) {
            setState(() {});
          }),
          builder: (context, snapshot) {
            return ReusableBottomSheet(
              future:
                  ref.read(instaBetController).toGetBetPlans().then((value) {
                setState(() {});
              }),
              getLength: dataList?.length ?? 5,
              title: 'Choose Bet Plan',
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
                  appBarTitle: "Fund Your Bet Accounts",
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
                          ref.read(instaBetController).betPlansModel.data,
                          (newStatus, val) {
                            // Handle the status change here if needed
                            setState(() {
                              betPlatform = newStatus?[val].name ?? '';
                              betPlatformId = newStatus?[val].id ?? 0;
                            });
                            debugPrint(
                                'New Bet Platform: $betPlatformId && $betPlatform');
                          },
                        );
                      },
                      child: ChooseContainerFromDropDown(
                        headerText: "Bet Platform",
                        hintText:
                            betPlatform == '' ? "Select Platform" : betPlatform,
                      ),
                    ),
                    CollectPersonalDetailModel(
                      leadTitle: "Account Number",
                      hintT: "XXX-XXX-XXXX",
                      isPasswordT: false,
                      isdigit: [FilteringTextInputFormatter.digitsOnly],
                      controller: betAccountNumberController,
                      textInputType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    CollectPersonalDetailModel(
                      leadTitle: "Amount",
                      hintT: "₦500",
                      isPasswordT: false,
                      isdigit: [FilteringTextInputFormatter.digitsOnly],
                      textInputType: TextInputType.number,
                      controller: amountController,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    CustomButton(
                      pageCTA: 'Validate',
                      buttonOnPressed: () {
                        setState(() {});
                        ref
                            .read(instaBetController)
                            .tovalidateBetData(
                              betPlatformId,
                              betAccountNumberController.text,
                            )
                            .then((value) {
                          if (value == true) {
                            setState(() {});
                            void showAlert(BuildContext context) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    "Fund Your Bet Account",
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
                                            .read(instaBetController.notifier)
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
                                            .read(instaBetController)
                                            .toBuyBetMoney(
                                              betPlatformId,
                                              betAccountNumberController.text,
                                              int.tryParse(
                                                      amountController.text) ??
                                                  0,
                                              ref
                                                  .read(instaBetController)
                                                  .userName,
                                            )
                                            .then((value) {
                                          if (value == true) {
                                            // Handle success
                                            setState(() {});
                                            AwesomeDialog(
                                              context:
                                                  _scaffoldKey.currentContext ??
                                                      context,
                                              animType: AnimType.scale,
                                              dialogType: DialogType.success,
                                              title: 'Order Successful',
                                              desc: ref
                                                  .read(instaBetController)
                                                  .message,
                                              btnOkOnPress: () {
                                                Navigator.pop(context);
                                              },
                                              onDismissCallback: (type) {
                                                Navigator.of(_scaffoldKey
                                                        .currentContext!)
                                                    .pop();
                                              },
                                            ).show();
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
                          }
                          setState(() {
                            ref.read(instaBetController).loadingState ==
                                LoadingState.idle;
                          });
                          AwesomeDialog(
                            context: _scaffoldKey.currentContext ?? context,
                            animType: AnimType.scale,
                            dialogType: DialogType.error,
                            title: 'Order Failed',
                            desc: 'Your order could not be placed',
                            onDismissCallback: (type) {
                              Navigator.of(_scaffoldKey.currentContext!).pop();
                            },
                            btnOkOnPress: () {
                              Navigator.pop(context);
                            },
                          ).show();
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
            ),
            if (ref.read(instaBetController).loadingState ==
                LoadingState.loading)
              const TransparentLoadingScreen(),
          ],
        ),
      ),
    );
  }
}
