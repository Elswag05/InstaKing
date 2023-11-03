import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class AuthTextField extends StatefulWidget {
  final IconData icon;
  final String hintT;
  final bool hasSuffix;
  final IconData suffixIcon;

  const AuthTextField({
    Key? key,
    required this.icon,
    required this.hintT,
    this.hasSuffix = false, // Set the default value to false
    this.suffixIcon = Icons.remove_red_eye_outlined,
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return TextFormField(
      style: TextStyle(
        fontSize: 13.sp,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        prefixIcon: Icon(
          color: EnvColors.darkColor.withOpacity(0.7),
          widget.icon,
        ),
        hintText: widget.hintT,
        hintStyle: TextStyle(
          fontFamily: 'Montesserat',
          fontSize: 13.sp,
          color: EnvColors.darkColor,
        ),
        suffixIcon: widget.hasSuffix
            ? Icon(widget.suffixIcon).afmPadding()
            : const SizedBox(),
        fillColor: EnvColors.lightColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            width: 1.sp,
            color: EnvColors.darkColor,
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
            color: EnvColors.darkColor,
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
    ).afmPadding(
        EdgeInsets.only(left: 20.w, right: 20.w, top: 10.sp, bottom: 10.sp));
  }
}
