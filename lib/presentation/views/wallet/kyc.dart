import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_wallet_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/bottom_sheet_modal.dart';
import 'package:insta_king/presentation/views/shared_widgets/choose_container.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

class KYCForBVN extends ConsumerStatefulWidget {
  const KYCForBVN({super.key});

  @override
  ConsumerState<KYCForBVN> createState() => _KYCForBVNState();
}

class _KYCForBVNState extends ConsumerState<KYCForBVN> {
  @override
  void initState() {
    super.initState();
    ref.watch(instaWalletController.notifier).toGetUserBanks();
  }

  String bankName = '';
  void showReusableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ReusableBottomSheet(
          future: ref
              .watch(instaWalletController.notifier)
              .toGetUserBanks()
              .then((value) {
            setState(() {});
          }),
          getLength:
              ref.watch(instaWalletController).getBanksModel.data?.length ?? 5,
          title: 'Choose Network',
          status: 'initialStatus', // Set your initial status here
          networkPr: ref.watch(instaWalletController).getBanksModel.data,
          onStatusChanged: (newStatus, netName) {
            // Handle the status change here if needed
            setState(() {
              // networkID = newStatus?[netName].id.toString() ?? '';
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
                      // setState(() {});
                    },
                    child: ChooseContainerFromDropDown(
                      headerText: "Bank",
                      hintText: bankName != '' ? bankName : "Choose Bank",
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
        ],
      )),
    );
  }
}
