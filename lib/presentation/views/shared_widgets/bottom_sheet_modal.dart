// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';

class ReusableBottomSheet extends StatefulWidget {
  final String title;
  final String status;
  final List<dynamic>? networkPr;
  final Function(List<dynamic>?, int) onStatusChanged;
  final int getLength;
  final Future<dynamic> future;

  const ReusableBottomSheet({
    super.key,
    required this.title,
    required this.status,
    this.networkPr,
    required this.onStatusChanged,
    required this.getLength,
    required this.future,
  });

  @override
  State<ReusableBottomSheet> createState() => _ReusableBottomSheetState();
}

class _ReusableBottomSheetState extends State<ReusableBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300.h,
          padding: EdgeInsets.only(
            left: 20.sp,
            right: 20.sp,
            top: 40.sp,
          ),
          decoration: BoxDecoration(
            color: InstaColors.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                55.r,
              ),
              topRight: Radius.circular(
                55.r,
              ),
            ),
          ),
          child: FutureBuilder(
            future: widget.future,
            builder: ((context, snapshot) {
              widget.future.whenComplete(() => () {
                    setState(() {});
                  });
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                        itemCount: widget.networkPr?.length ?? 5,
                        itemExtent: 60.sp,
                        padding: EdgeInsets.only(
                          bottom: 5.h,
                        ),
                        shrinkWrap: (widget.getLength > 5),
                        itemBuilder: (context, index) {
                          return ListTile(
                            visualDensity: VisualDensity.standard,
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Center(
                              child: Text(
                                widget.networkPr?[index].name,
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Montesserat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                              ),
                            ),
                            onTap: () {
                              widget.onStatusChanged(widget.networkPr, index);
                              Navigator.of(context).pop();
                            },
                          );
                        }),
                  );
                // case ConnectionState.active:
                //   return const TransparentLoadingScreen();
                case ConnectionState.waiting:
                  return const TransparentLoadingScreen();
                default:
                  return const TransparentLoadingScreen();
              }
            }),
          ),
        ),
      ],
    ).afmNeverScroll;
  }
}
