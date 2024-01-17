import 'dart:ui';

import 'package:custom_context_menu/custom_context_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/core/theme/env_theme_manager.dart';

class CollectPersonalDetailModel extends StatefulWidget {
  final String leadTitle;
  final String hintT;
  final bool isPasswordT;
  final int? numberOfTexts;
  final List<TextInputFormatter>? isdigit;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  const CollectPersonalDetailModel({
    super.key,
    required this.leadTitle,
    required this.hintT,
    this.isPasswordT = false,
    this.isdigit,
    this.controller,
    this.validator,
    this.onChanged,
    this.numberOfTexts,
  });

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
          enableInteractiveSelection: true,
          selectionControls: MaterialTextSelectionControls(),
          selectionHeightStyle: BoxHeightStyle.max,
          obscureText: widget.isPasswordT,
          controller: widget.controller,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.always,
          inputFormatters: widget.isdigit,
          maxLength: widget.numberOfTexts,
          onChanged: widget.onChanged,
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
            ),
            fillColor: Theme.of(context).cardColor,
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
          contextMenuBuilder:
              (BuildContext context, EditableTextState editableTextState) {
            return CustomContextMenu(
              editableTextState: editableTextState,
              backgroundColor: Theme.of(context).colorScheme.background,
              disabledColor: Theme.of(context).colorScheme.primary,
              borderRadius: 0,
              buttonPadding: 0,
              textStyle: TextStyle(
                fontSize: 13.sp,
              ),
            );
          },
        ).afmPadding(EdgeInsets.only(top: 10.sp, bottom: 10.sp))
      ],
    );
  }
}
