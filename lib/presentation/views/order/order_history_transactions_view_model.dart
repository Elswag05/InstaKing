import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/presentation/views/services/insta_services.dart';

class OrderHistoryViewModel extends StatefulWidget {
  final String idText;
  final String dateHere;
  final String linkHere;
  final String priceHere;
  final String digitHere;
  final String quantity;
  final String serviceHere;
  final String remNant;
  final Widget status;
  const OrderHistoryViewModel(
      {super.key,
      required this.idText,
      required this.dateHere,
      required this.linkHere,
      required this.priceHere,
      required this.digitHere,
      required this.quantity,
      required this.serviceHere,
      required this.remNant,
      required this.status});

  @override
  State<OrderHistoryViewModel> createState() => _OrderHistoryViewModelState();
}

class _OrderHistoryViewModelState extends State<OrderHistoryViewModel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      child: Stack(
        children: [
          lightText('ID', context),
          Positioned(
            left: MediaQuery.of(context).size.width / 2.5.w,
            child: darkText(widget.idText, context),
          ),
          Positioned(
            top: 20.h,
            child: lightText('DATE', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2.5.w,
            top: 20.h,
            child: SizedBox(
              height: 47.h,
              width: 200,
              child: darkText(widget.dateHere, context),
            ),
          ),
          Positioned(
            top: 40.h,
            child: lightText('Link', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2.5.w,
            top: 40.h,
            child: SizedBox(
              height: 20.h,
              width: 250,
              child: darkText(widget.linkHere, context),
            ),
          ),
          Positioned(
            top: 60.h,
            child: lightText('Price', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2.5.w,
            top: 60.h,
            child: SizedBox(
              height: 47.h,
              width: 150,
              child: darkText(widget.priceHere, context),
            ),
          ),
          Positioned(
            top: 80.h,
            child: lightText('Start', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2.5.w,
            top: 80.h,
            child: SizedBox(
              height: 20.h,
              width: 80.w,
              child: darkText(widget.digitHere, context),
            ),
          ), //₦
          Positioned(
            top: 100.h,
            child: lightText('Quantity', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2.5.w,
            top: 100.h,
            child: darkText(widget.quantity, context),
          ),
          Positioned(
            top: 130.h,
            child: lightText('Service', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2.5.w,
            top: 130.h,
            child: SizedBox(
              height: 50.h,
              width: 250.w,
              child: darkText(widget.serviceHere, context),
            ),
          ),
          Positioned(
            top: 170.h,
            child: lightText('Remaining', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2.5.w,
            top: 170.h,
            child: SizedBox(
              height: 20.h,
              width: 80.w,
              child: darkText(widget.remNant, context),
            ),
          ),
          Positioned(
            top: 190.h,
            child: lightText('Status', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2.5.w,
            top: 190.h,
            child: SizedBox(
              height: 20.h,
              width: 150.w,
              child: widget.status,
            ),
          ),
          Positioned(
            bottom: 0.sp,
            child: Container(
              width: MediaQuery.of(context).size.width - 40.sp,
              height: 1.sp,
              color: InstaColors.primaryColor,
              margin: EdgeInsets.symmetric(vertical: 10.sp),
            ),
          )
        ],
      ),
    );
  }
}
