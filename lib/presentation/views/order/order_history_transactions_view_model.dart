import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/presentation/views/services/service_widgets.dart';
import 'package:insta_king/utils/locator.dart';

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
  //late String orderService;

  @override
  void initState() {
    // orderService = 'loading...';
    super.initState();
  }

  // Future<void> fetchData() async {
  //   setState(() {
  //     orderService = widget.serviceHere;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // fetchData();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 10.h),
      height: 240.h,
      child: Stack(
        children: [
          lightText('ORDER ID', context),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            child: GestureDetector(
              onTap: () {
                Clipboard.setData(
                  ClipboardData(text: widget.idText),
                );
                locator<ToastService>().showSuccessToast(
                  'You have copied your order ID',
                );
              },
              child: Row(
                children: [
                  darkText(widget.idText, context),
                  Icon(
                    Icons.copy_rounded,
                    size: 13.sp,
                    color: InstaColors.primaryColor,
                  ).afmPadding(
                    EdgeInsets.only(left: 5.w),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20.h,
            child: lightText('SERVICE', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 20.h,
            child: SizedBox(
              height: 50.h,
              width: 250.w,
              child: darkText(widget.serviceHere, context),
            ),
          ),
          Positioned(
            top: 60.h,
            child: lightText('DATE', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 60.h,
            child: SizedBox(
              height: 47.h,
              width: 200,
              child: darkText(widget.dateHere, context),
            ),
          ),
          Positioned(
            top: 80.h,
            child: lightText('LINK', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 80.h,
            child: SizedBox(
              height: 20.h,
              width: 250,
              child: Text(
                widget.linkHere,
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Positioned(
            top: 100.h,
            child: lightText('PRICE', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 100.h,
            child: SizedBox(
              height: 47.h,
              width: 150,
              child: darkText(widget.priceHere, context),
            ),
          ),
          Positioned(
            top: 120.h,
            child: lightText('START', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 120.h,
            child: SizedBox(
              height: 20.h,
              width: 80.w,
              child: darkText(widget.digitHere, context),
            ),
          ), //₦
          Positioned(
            top: 140.h,
            child: lightText('QUANTITY', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 140.h,
            child: darkText(widget.quantity, context),
          ),

          Positioned(
            top: 160.h,
            child: lightText('REMAINING', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 160.h,
            child: SizedBox(
              height: 20.h,
              width: 80.w,
              child: darkText(widget.remNant, context),
            ),
          ),
          Positioned(
            top: 180.h,
            child: lightText('STATUS', context),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 4.w,
            top: 180.h,
            child: SizedBox(
              height: 20.h,
              width: 100.w,
              child: widget.status,
            ),
          ),
          // Positioned(
          //   bottom: 0.sp,
          //   child: Container(
          //     width: MediaQuery.of(context).size.width - 40.sp,
          //     height: 1.sp,
          //     color: InstaColors.primaryColor,
          //     margin: EdgeInsets.symmetric(vertical: 10.sp),
          //   ),
          // )
        ],
      ),
    );
  }
}
