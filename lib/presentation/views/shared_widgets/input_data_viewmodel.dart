import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class CollectPersonalDetailModel extends StatefulWidget {
  final String leadTitle;
  final String hintT;
  final bool isPasswordT;
  final List<TextInputFormatter>? isdigit;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  const CollectPersonalDetailModel(
      {super.key,
      required this.leadTitle,
      required this.hintT,
      this.isPasswordT = false,
      this.isdigit,
      this.controller,
      this.validator,
      this.onChanged});

  @override
  State<CollectPersonalDetailModel> createState() =>
      _CollectPersonalDetailModelState();
}

class _CollectPersonalDetailModelState
    extends State<CollectPersonalDetailModel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.leadTitle,
          style: TextStyle(
            fontFamily: 'Montesserat',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          obscureText: widget.isPasswordT,
          controller: widget.controller,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.always,
          inputFormatters: widget.isdigit,
          onChanged: widget.onChanged,
          style: TextStyle(
            fontSize: 13.sp,
            color: InstaColors.darkColor,
          ),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            hintText: widget.hintT,
            hintStyle: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 13.sp,
              color: InstaColors.mildGrey,
            ),
            fillColor: InstaColors.lightColor,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                width: 0.5.sp,
                color: InstaColors.darkColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                width: 0.5.sp,
                color: InstaColors.darkColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                width: 0.5.sp,
                color: InstaColors.darkColor.withOpacity(0.5),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                width: 0.5.sp,
                color: InstaColors.errorColor,
              ),
            ),
          ),
        ).afmPadding(EdgeInsets.only(top: 10.sp, bottom: 10.sp))
      ],
    );
  }
}



        // widget.isDesciptionT
        //     ? SizedBox(
        //         height: 100.h,
        //         width: MediaQuery.of(context).size.width - 20.sp,
        //         child: TextField(
        //           readOnly: true, // Prevents user input
        //           maxLines: null,
        //           expands: true,
        //           controller: widget.controller,
        //           keyboardType: TextInputType.multiline,
        //           textAlignVertical:
        //               TextAlignVertical.top, // Align text to the top
        //           decoration: InputDecoration(
        //             contentPadding:
        //                 EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        //             hintText: widget.hintT,
        //             hintStyle: TextStyle(
        //               fontFamily: 'Montesserat',
        //               fontSize: 13.sp,
        //               color: InstaColors.mildGrey,
        //             ),
        //             fillColor: InstaColors.lightColor,
        //             filled: true,
        //             enabledBorder: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(10.r),
        //               borderSide: BorderSide(
        //                 width: 0.5.sp,
        //                 color: InstaColors.darkColor.withOpacity(0.3),
        //               ),
        //             ),
        //             focusedBorder: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(10.r),
        //               borderSide: BorderSide(
        //                 width: 0.5.sp,
        //                 color: InstaColors.darkColor,
        //               ),
        //             ),
        //             disabledBorder: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(10.r),
        //               borderSide: BorderSide(
        //                 width: 0.5.sp,
        //                 color: InstaColors.darkColor.withOpacity(0.5),
        //               ),
        //             ),
        //             errorBorder: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(10.r),
        //               borderSide: BorderSide(
        //                 width: 0.5.sp,
        //                 color: InstaColors.errorColor,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ).afmPadding(
        //         EdgeInsets.only(top: 10.sp, bottom: 10.sp),
        //       )
        //     :