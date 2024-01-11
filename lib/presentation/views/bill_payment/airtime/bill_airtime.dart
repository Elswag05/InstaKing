import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/purchase_airtime_controller.dart';
import 'package:insta_king/presentation/controllers/text_editing_controller.dart';
import 'package:insta_king/presentation/views/bill_payment/airtime/airtime_widgets.dart';
import 'package:insta_king/presentation/views/bill_payment/bottom_sheet_modal.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/bank_account_details/bank_account_details.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

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
  final TextEditingController amountController = TextEditingController();
  late TextValueNotifier textValueNotifier = ref.read(textValueProvider);
  @override
  void initState() {
    textValueNotifier = ref.read(textValueProvider);
    ref.read(instaAirtimeController).toGetNetworks();
    super.initState();
  }

  void showReusableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ReusableBottomSheet(
          title: 'Choose Network',
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
          child: Column(
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
                child: const ChooseContainerFromDropDown(
                  headerText: "Network",
                  hintText: "Choose Network",
                ),
              ),
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
            ],
          ).afmPadding(
            EdgeInsets.symmetric(
              horizontal: 20.sp,
            ),
          ),
        ],
      )),
    );
  }
}
