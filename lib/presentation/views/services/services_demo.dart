import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/presentation/controllers/insta_categories_controller.dart';
import 'package:insta_king/presentation/views/services/service_widgets.dart';
import 'package:insta_king/presentation/views/services/services_widget_model.dart';

class ServicesDemoWidget extends StatefulWidget {
  final int index;

  const ServicesDemoWidget({super.key, required this.index});

  @override
  State<ServicesDemoWidget> createState() => _ServicesDemoWidgetState();
}

class _ServicesDemoWidgetState extends State<ServicesDemoWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final service =
            ref.watch(instaCategoriesController).getAllServicesModel;
        final filteredData = ref.watch(instaCategoriesController).filteredData;

        final bool hasTappedStatus = _hasTappedStatus();
        return Container(
          width: MediaQuery.of(context).size.width - 40.sp,
          height: 140.h,
          padding: EdgeInsets.all(15.sp),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: hasTappedStatus
              ? Text(filteredData.toString())
              : ServiceWidgetModel(
                  idtext:
                      service.data?[widget.index].id.toString() ?? 'Loading...',
                  name: service.data?[widget.index].name.toString() ??
                      'Loading...',
                  price: service.data?[widget.index].price
                          .toString()
                          .roundUpToDecimalPlaces(2) ??
                      'Loading...',
                  min: service.data?[widget.index].min.toString() ??
                      'Loading...',
                  max: service.data?[widget.index].max.toString() ?? '',
                ),
        );
      },
    );
  }

  bool _hasTappedStatus() {
    return hasInstagramBeenTapped ||
        hasFacebookBeenTapped ||
        hasYoutubeBeenTapped ||
        hasSpotifyBeenTapped ||
        hasSnapchatBeenTapped ||
        hasTelegramBeenTapped ||
        hasAudiomackBeenTapped ||
        hasTiktokBeenTapped ||
        hasDeezerBeenTapped;
  }
}
