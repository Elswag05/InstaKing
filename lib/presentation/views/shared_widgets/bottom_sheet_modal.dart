import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

class ReusableBottomSheet extends StatelessWidget {
  final String title;
  final String status;
  final List<dynamic>? networkPr;
  final Function(List<dynamic>?, int) onStatusChanged;
  final int getLength;

  const ReusableBottomSheet({
    super.key,
    required this.title,
    required this.status,
    required this.onStatusChanged,
    this.networkPr,
    required this.getLength,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          height: (networkPr?.length ?? 5) * 70.h,
          padding: EdgeInsets.only(
            left: 20.sp,
            right: 20.sp,
            top: 40.sp,
          ),
          decoration: BoxDecoration(
            color: InstaColors.primaryColor.withOpacity(0.8),
            border: Border.all(
              width: 0.5,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                55.r,
              ),
              topRight: Radius.circular(
                55.r,
              ),
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: (networkPr?.length ?? 4) * 40.h,
                child: ListView.builder(
                    itemCount: networkPr?.length,
                    padding: EdgeInsets.only(
                      bottom: 5.h,
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(
                        visualDensity: VisualDensity.standard,
                        title: Text(
                          networkPr?[index].name ?? 'loading...',
                          style: TextStyle(
                            fontFamily: "Monteserrat",
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        onTap: () {
                          onStatusChanged(networkPr, index);
                          Navigator.of(context).pop();
                        },
                      );
                    }),
              ),
            ],
          ).afmNeverScroll,
        );
      },
    );
  }
}
