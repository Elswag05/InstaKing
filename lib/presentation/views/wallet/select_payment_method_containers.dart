// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/presentation/controllers/insta_wallet_controller.dart';

class SelectPaymentContainer extends ConsumerStatefulWidget {
  const SelectPaymentContainer({
    super.key,
  });

  @override
  SelectPaymentContainerState createState() => SelectPaymentContainerState();
}

class SelectPaymentContainerState
    extends ConsumerState<SelectPaymentContainer> {
  int activeIndex = -1;
  List<String> methodImages = <String>[
    EnvAssets.getImagePath("coinbase"),
    EnvAssets.getImagePath("flutterwave"),
    // EnvAssets.getImagePath("paypal"),
    // EnvAssets.getImagePath("perfect_money"),
  ];
  List<String> methodNames = <String>[
    "Coinbase",
    "Flutterwave",
    // "paypal",
    // "perfect_money",
  ];

  void setActiveIndex(int index) {
    setState(() {
      activeIndex = index;
      ref.read(instaWalletController).depositInt = activeIndex;
      ref.read(instaWalletController).depositMethodValue =
          methodNames[ref.read(instaWalletController).depositInt];
    });
  }

  Widget buildContainer(int index) {
    bool isActive = index == activeIndex;

    return GestureDetector(
      onTap: () {
        setActiveIndex(index);
      },
      child: Container(
        height: 50.h,
        margin: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: isActive ? Colors.transparent : Colors.transparent,
          border: isActive
              ? Border.all(color: InstaColors.primaryColor, width: 2)
              : Border.all(
                  color: Colors.transparent,
                ),
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7.r),
          child: Image.asset(
            methodImages[index],
            fit: BoxFit.cover,
            width: 80,
            height: 80,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        2,
        (index) => Expanded(
          child: buildContainer(index),
        ),
      ),
    );
  }
}
