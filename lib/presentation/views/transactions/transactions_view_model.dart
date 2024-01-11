import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/presentation/views/services/service_widgets.dart';

class TransactionViewModel extends StatefulWidget {
  // final String no;
  // final Widget type;
  final Widget service;
  final String trxCode;
  final String date;
  final String amount;
  // final Widget status;
  final String message;

  const TransactionViewModel({
    super.key,
    // required this.no,
    // required this.status,
    // required this.type,
    required this.service,
    required this.trxCode,
    required this.date,
    required this.amount,
    required this.message,
  });

  @override
  State<TransactionViewModel> createState() => _OrderHistoryViewModelState();
}

class _OrderHistoryViewModelState extends State<TransactionViewModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40.sp,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 10.h),
      height: 160.h,
      child: Stack(
        children: [
          // Positioned(
          //   top: 0.h,
          //   child: lightText('TYPE', context),
          // ),
          // Positioned(
          //   left: MediaQuery.of(context).size.width / 4.w,
          //   top: 0.h,
          //   child: widget.type,
          // ),
          Positioned(
            top: 10.h,
            child: lightText('SERVICE', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 0.h,
            child: widget.service,
          ),
          Positioned(
            top: 30.h,
            child: lightText('TRX CODE', context),
          ),
          Positioned(
              left: MediaQuery.of(context).size.width / 4.w,
              top: 30.h,
              child: darkText(widget.trxCode, context)),
          Positioned(
            top: 50.h,
            child: lightText('DATE', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 50.h,
            child: darkText(widget.date, context),
          ),
          Positioned(
            top: 70.h,
            child: lightText('AMOUNT', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 70.h,
            child: darkText(widget.amount, context),
          ), //₦
          Positioned(
            top: 90.h,
            child: lightText('MESSAGE', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 90.h,
            child: SizedBox(
              height: 50.h,
              width: 80.w,
              child: darkText(widget.message, context),
            ),
          ),
        ],
      ),
    );
  }
}
