import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/order/place_order/dropdown_model.dart';

class SharedDropDown extends StatefulWidget {
  final String text;
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>> dropdownItems;
  final Future<Object?>? future;
  String selectedValue;

  SharedDropDown(
      {super.key,
      required this.text,
      required this.dropdownItems,
      this.future,
      required this.selectedValue,
      this.onChanged});

  @override
  State<SharedDropDown> createState() => _SharedDropDownState();
}

class _SharedDropDownState extends State<SharedDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: TextStyle(
            fontFamily: 'Montesserat',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: InstaColors.mildGrey,
          ),
        ).afmPadding(
          EdgeInsets.only(bottom: 5.sp),
        ),
        DropDownWidget(
          future: widget.future,
          selectedValue: widget.selectedValue,
          dropdownItems: widget.dropdownItems,
          onChanged: widget.onChanged,
        ),
      ],
    ).afmPadding(
      EdgeInsets.only(bottom: 10.h),
    );
  }
}



//  Container(
//           height: 40.h,
//           decoration: BoxDecoration(
//             color: InstaColors.lightColor,
//             border: Border.all(
//               width: 0.5.sp,
//             ),
//             borderRadius: BorderRadius.circular(10.r),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 hintText,
//                 style: TextStyle(
//                   fontFamily: 'Montesserat',
//                   fontSize: 13.sp,
//                   fontWeight: FontWeight.w500,
//                   color: InstaColors.mildGrey,
//                 ),
//               ).afmPadding(EdgeInsets.only(left: 10.w)),
//               Icon(
//                 Icons.keyboard_arrow_down_rounded,
//                 size: 20.sp,
//                 color: InstaColors.mildGrey,
//               ).afmPadding(EdgeInsets.only(right: 6.h)),
//             ],
//           ),
//         ).afmPadding(EdgeInsets.only(top: 10.sp, bottom: 10.sp)),