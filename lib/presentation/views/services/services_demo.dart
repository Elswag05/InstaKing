import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/presentation/controllers/insta_categories_controller.dart';
import 'package:insta_king/presentation/views/services/service_widgets.dart';
import 'package:insta_king/presentation/views/services/services_widget_model.dart';

class ServicesDemoWidget extends ConsumerStatefulWidget {
  final int index;

  const ServicesDemoWidget({super.key, required this.index});

  @override
  ConsumerState<ServicesDemoWidget> createState() => _ServicesDemoWidgetState();
}

class _ServicesDemoWidgetState extends ConsumerState<ServicesDemoWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final service = ref.watch(instaCategoriesController).servicesModel;
        debugPrint('Length of servicesModel: ${service.length}');
        //    final filteredData = ref.watch(instaCategoriesController).filteredData;
        //   debugPrint('This is the filtered Data ==?> $filteredData');
        return Container(
          width: MediaQuery.of(context).size.width - 40.sp,
          height: 140.h,
          padding: EdgeInsets.all(15.sp),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: ServiceWidgetModel(
            idtext: service[widget.index].id.toString(),
            name: service[widget.index].name.toString(),
            price: service[widget.index]
                .price
                .toString()
                .roundUpToDecimalPlaces(2),
            min: service[widget.index].min.toString(),
            max: service[widget.index].max.toString(),
          ),
        );
      },
    );
  }
}
