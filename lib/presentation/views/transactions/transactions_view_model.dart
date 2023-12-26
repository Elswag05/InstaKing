import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/presentation/views/services/insta_services.dart';
import 'package:insta_king/utils/locator.dart';

class TransactionViewModel extends StatefulWidget {
  final String no;
  final Widget type;
  final Widget service;
  final String trxCode;
  final String date;
  final String amount;
  final Widget status;
  final String message;

  const TransactionViewModel({
    super.key,
    required this.no,
    required this.status,
    required this.type,
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
        color: InstaColors.lightColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 10.h),
      height: 240.h,
      child: Stack(
        children: [
          lightText('#', context),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            child: darkText(widget.no, context),
          ),
          Positioned(
            top: 20.h,
            child: lightText('TYPE', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 20.h,
            child: widget.type,
          ),
          Positioned(
            top: 40.h,
            child: lightText('SERVICE', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 40.h,
            child: widget.service,
          ),
          Positioned(
            top: 60.h,
            child: lightText('TRX CODE', context),
          ),
          Positioned(
              left: MediaQuery.of(context).size.width / 4.w,
              top: 60.h,
              child: darkText(widget.trxCode, context)),
          Positioned(
            top: 80.h,
            child: lightText('DATE', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 80.h,
            child: darkText(widget.date, context),
          ),
          Positioned(
            top: 100.h,
            child: lightText('AMOUNT', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 100.h,
            child: darkText(widget.amount, context),
          ), //₦
          Positioned(
            top: 120.h,
            child: lightText('STATUS', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 120.h,
            child: widget.status,
          ),
          Positioned(
            top: 140.h,
            child: lightText('MESSAGE', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 140.h,
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
