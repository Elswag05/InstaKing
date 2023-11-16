import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class CollectPersonalDetailModel extends StatefulWidget {
  final String leadTitle;
  final String hintT;
  final bool isPasswordT;
  final bool isDesciptionT;
  final TextEditingController? controller;
  const CollectPersonalDetailModel(
      {super.key,
      required this.leadTitle,
      required this.hintT,
      this.isPasswordT = false,
      this.isDesciptionT = false,
      this.controller});

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
            color: EnvColors.darkColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        widget.isDesciptionT
            ? SizedBox(
                height: 100.h,
                width: MediaQuery.of(context).size.width - 20.sp,
                child: TextField(
                  maxLines: null,
                  expands: true,
                  controller: widget.controller,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                    hintText: widget.hintT,
                    hintStyle: TextStyle(
                      fontFamily: 'Montesserat',
                      fontSize: 13.sp,
                      color: EnvColors.darkColor.withOpacity(0.5),
                    ),
                    fillColor: EnvColors.mildLightColor,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        width: 1.sp,
                        color: EnvColors.darkColor.withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        width: 1.sp,
                        color: EnvColors.darkColor,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        width: 1.sp,
                        color: EnvColors.darkColor.withOpacity(0.5),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        width: 1.sp,
                        color: EnvColors.errorColor,
                      ),
                    ),
                  ),
                ),
              ).afmPadding(
                EdgeInsets.only(top: 10.sp, bottom: 10.sp),
              )
            : TextFormField(
                obscureText: widget.isPasswordT,
                style: TextStyle(
                  fontSize: 13.sp,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                  hintText: widget.hintT,
                  hintStyle: TextStyle(
                    fontFamily: 'Montesserat',
                    fontSize: 13.sp,
                    color: EnvColors.darkColor.withOpacity(0.5),
                  ),
                  fillColor: EnvColors.lightColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      width: 1.sp,
                      color: EnvColors.darkColor.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      width: 1.sp,
                      color: EnvColors.darkColor,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      width: 1.sp,
                      color: EnvColors.darkColor.withOpacity(0.5),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      width: 1.sp,
                      color: EnvColors.errorColor,
                    ),
                  ),
                ),
              ).afmPadding(EdgeInsets.only(top: 10.sp, bottom: 10.sp))
      ],
    );
  }
}
