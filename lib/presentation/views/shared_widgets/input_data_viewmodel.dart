import 'dart:ui';

import 'package:custom_context_menu/custom_context_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class CollectPersonalDetailModel extends StatefulWidget {
  final String leadTitle;
  final String hintT;
  final bool isPasswordT;
  final int? numberOfTexts;
  final List<TextInputFormatter>? isdigit;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputType? textInputType;
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
    this.textInputType = TextInputType.text,
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
          // selectionControls: MaterialTextSelectionControls(),
          selectionHeightStyle: BoxHeightStyle.max,
          obscureText: widget.isPasswordT,
          controller: widget.controller,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.always,
          inputFormatters: widget.isdigit,
          maxLength: widget.numberOfTexts,
          onChanged: widget.onChanged,
          keyboardType: widget.textInputType,
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
                color: Theme.of(context).unselectedWidgetColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                width: 0.5.sp,
                color: Theme.of(context).unselectedWidgetColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                width: 0.5.sp,
                color: Theme.of(context).unselectedWidgetColor,
              ),
            ),
          ),
          contextMenuBuilder:
              (BuildContext context, EditableTextState editableTextState) {
            return CustomContextMenu(
              editableTextState: editableTextState,
              backgroundColor: Theme.of(context).colorScheme.primary,
              disabledColor: Theme.of(context).colorScheme.primary,
              borderRadius: 0,
              buttonPadding: 0,
              textStyle: TextStyle(
                fontFamily: 'Montesserat',
                fontSize: 13.sp,
              ),
            );
          },
        ).afmPadding(EdgeInsets.only(top: 10.sp, bottom: 10.sp))
      ],
    );
  }
}
