import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/presentation/model/get_all_order_model.dart';

class StatusContainer extends StatelessWidget {
  final Status status;

  // Constructor to receive the status
  const StatusContainer({super.key, required this.status});

  // Method to get the color based on the status
  Color getColor() {
    switch (status) {
      case Status.PARTIAL:
        return Colors.blue;
      case Status.COMPLETED:
        return Colors.green;
      case Status.PROCESSING:
        return Colors.orange;
      case Status.CANCELED:
        return Colors.red;
      case Status.PENDING:
        return Colors.brown;
    }
  }

  // Method to get the text based on the status
  String getStatusText() {
    switch (status) {
      case Status.PARTIAL:
        return 'In Progress';
      case Status.COMPLETED:
        return 'Completed';
      case Status.PROCESSING:
        return 'Processing';
      case Status.CANCELED:
        return 'Cancelled';
      case Status.PENDING:
        return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: getColor(),
        borderRadius: BorderRadius.circular(5.r),
      ), // Get color based on status
      child: Center(
        child: AutoSizeText(
          getStatusText(), // Get text based on status
          minFontSize: 8.sp,
          stepGranularity: 2.sp,
          maxFontSize: 12.sp,
          style: const TextStyle(
            fontFamily: 'Montesserat',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
