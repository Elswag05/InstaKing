import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

// class DropDownWidget extends StatefulWidget {
//   final List<DropdownMenuItem<String>> dropdownItems;
//   final Future<Object?>? future;
//   String selectedValue;
//   final void Function(String?)? onChanged;

//   DropDownWidget({
//     super.key,
//     required this.dropdownItems,
//     required this.future,
//     required this.selectedValue,
//     this.onChanged,
//   });

//   @override
//   State<DropDownWidget> createState() => _DropDownWidgetState();
// }

// class _DropDownWidgetState extends State<DropDownWidget> {
//   bool isDropdownDisabled(List<DropdownMenuItem<String>> dropdown) {
//     return dropdown.isEmpty ? true : false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: widget.future,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           log('Info: dropdown items are => ${widget.dropdownItems.toString()}');
//           return buildDropdown();
//         } else {
//           return buildLoadingContainer();
//         }
//       },
//     );
//   }

//   Widget buildDropdown() {
//     return DropdownButtonFormField(
//       elevation: 0,
//       icon: Icon(Icons.keyboard_arrow_down_outlined, size: 14.sp),
//       isExpanded: true,
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//         hintText: "Choose A Category",
//         hintStyle: const TextStyle(color: Colors.grey),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(width: 0.5.sp),
//           borderRadius: BorderRadius.circular(14),
//         ),
//         border: OutlineInputBorder(
//           borderSide:
//               BorderSide(color: Theme.of(context).cardColor, width: 0.5.sp),
//           borderRadius: BorderRadius.circular(14),
//         ),
//         filled: true,
//         fillColor: InstaColors.lightColor,
//       ),
//       dropdownColor: InstaColors.lightColor,
//       value: widget.selectedValue,
//       onChanged: isDropdownDisabled(widget.dropdownItems)
//           ? (String? string) {
//               setState(() {
//                 locator<ToastService>()
//                     .showErrorToast('Please Try Again Later');
//               });
//             }
//           : widget.onChanged,
//       items: widget.dropdownItems,
//     );
//   }

Widget buildLoadingContainer(String keyWord, heading, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        heading,
        style: TextStyle(
          fontFamily: 'Montesserat',
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: InstaColors.lightColor,
          border: Border.all(
            width: 0.5.sp,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: AutoSizeText(
                keyWord,
                stepGranularity: 2.sp,
                minFontSize: 12.sp,
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: InstaColors.mildGrey,
                  overflow: TextOverflow.ellipsis,
                ),
              ).afmPadding(EdgeInsets.only(left: 10.w)),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20.sp,
              color: InstaColors.mildGrey,
            ).afmPadding(EdgeInsets.only(right: 6.h)),
          ],
        ),
      ).afmPadding(EdgeInsets.only(top: 10.sp, bottom: 10.sp)),
    ],
  );
}

//}
