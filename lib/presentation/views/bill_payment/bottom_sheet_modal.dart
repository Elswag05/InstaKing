import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/presentation/controllers/purchase_airtime_controller.dart';
import 'package:insta_king/presentation/model/get_network_model.dart';

class ReusableBottomSheet extends StatelessWidget {
  final String title;
  final String status;
  final Function(String) onStatusChanged;

  const ReusableBottomSheet({
    super.key,
    required this.title,
    required this.status,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final networkPr = ref.read(instaAirtimeController).getNetworkModel.data;
        return SizedBox(
          height:
              (ref.read(instaAirtimeController).getNetworkModel.data?.length ??
                      5) *
                  80.h,
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
                          style: TextStyle(
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
              // ListTile(
              //   leading: const Icon(Icons.stop_circle_outlined),
              //   title: const Text(
              //     'OFF',
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       color: Colors.red,
              //     ),
              //   ),
              //   onTap: () {
              //     onStatusChanged('OFF');
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }
}

class InstaBottomSheet extends StatefulWidget {
  const InstaBottomSheet({required Key key, required this.title})
      : super(key: key);

  final String title;

  @override
  InstaBottomSheetState createState() => InstaBottomSheetState();
}

class InstaBottomSheetState extends State<InstaBottomSheet> {
  String status = 'null';

  void bottomSheetDisplay(
          BuildContext context, List<GetNetworkModel> networkData) =>
      showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return ReusableBottomSheet(
            title: widget.title,
            status: status,
            onStatusChanged: (newStatus) {
              setState(() {
                status = newStatus;
              });
            },
            // networkData: networkData,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
