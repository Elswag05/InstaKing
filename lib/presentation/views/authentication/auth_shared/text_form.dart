import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class AuthTextField extends StatefulWidget {
  final IconData icon;
  final String hintT;
  final bool hasSuffix;
  final IconData suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;

  const AuthTextField({
    Key? key,
    required this.icon,
    required this.hintT,
    this.hasSuffix = false, // Set the default value to false
    this.suffixIcon = Icons.remove_red_eye_outlined,
    this.controller,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool showPassword = true;

  void toShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  Widget eyeToHidePassword() {
    return GestureDetector(
        onTap: toShowPassword,
        child: showPassword
            ? Icon(widget.suffixIcon).afmPadding()
            : const Icon(Icons.visibility_off_outlined).afmPadding());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: TextFormField(
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(
          fontSize: 13.sp,
        ),
        obscureText: widget.isPassword ? showPassword : false,
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          prefixIcon: Icon(
            widget.icon,
          ),
          hintText: widget.hintT,
          hintStyle: TextStyle(
            fontFamily: 'Montesserat',
            fontSize: 13.sp,
          ),
          suffixIcon:
              (widget.hasSuffix) ? eyeToHidePassword() : const SizedBox(),
          filled: true,
          fillColor: InstaColors.lightColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              width: 0.5.sp,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              width: 0.5.sp,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              width: 0.5.sp,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              width: 0.5.sp,
              color: InstaColors.errorColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              width: 0.5.sp,
              color: InstaColors.errorColor,
            ),
          ),
        ),
      ).afmPadding(
          EdgeInsets.only(left: 20.w, right: 20.w, top: 10.sp, bottom: 10.sp)),
    );
  }
}
