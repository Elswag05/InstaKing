import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/presentation/controllers/purchase_airtime_controller.dart';
import 'package:insta_king/presentation/model/get_network_model.dart';

class ReusableBottomSheet extends StatelessWidget {
  final String title;
  final String status;
  final List<Datum>? networkPr;
  final Function(String) onStatusChanged;
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
        final networkPr = ref.read(instaAirtimeController).getNetworkModel.data;
        return Container(
          height:
              (ref.read(instaAirtimeController).getNetworkModel.data?.length ??
                      5) *
                  80.h,
          padding: EdgeInsets.only(
            left: 20.sp,
            right: 20.sp,
            top: 40.sp,
          ),
          decoration: BoxDecoration(
            color: InstaColors.primaryColor,
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
                height: (ref
                            .read(instaAirtimeController)
                            .getNetworkModel
                            .data
                            ?.length ??
                        4) *
                    50.h,
                child: ListView.builder(
                    itemCount: ref
                        .read(instaAirtimeController)
                        .getNetworkModel
                        .data
                        ?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.play_circle_outline),
                        title: Text(
                          networkPr?[index].name ?? 'loading...',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          onStatusChanged('ON');
                          Navigator.of(context).pop();
                        },
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
