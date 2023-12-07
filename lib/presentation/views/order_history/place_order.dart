import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/order_history/order_chips.dart';
import 'package:insta_king/presentation/views/shared_widgets/mini_tags.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

class PlaceOrder extends StatelessWidget {
  const PlaceOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const RecurringAppBar(appBarTitle: "Place Order")
              .afmPadding(EdgeInsets.only(bottom: 10.h)),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SharedDropDown(
                  text: 'Category',
                  hintText: 'Choose a category',
                ),
                const SharedDropDown(
                  text: 'Service',
                  hintText: 'Choose a service',
                ),
                const CollectPersonalDetailModel(
                  leadTitle: "Link",
                  hintT: 'https://',
                  isPasswordT: true,
                ),
                const CollectPersonalDetailModel(
                  leadTitle: "Quantity",
                  hintT: '1',
                  isPasswordT: true,
                ),
                const Row(
                  children: [
                    MiniTags(textOnTag: 'Min - Max'),
                    MiniTags(textOnTag: 'Per 1k: #4000'),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                const CollectPersonalDetailModel(
                  leadTitle: "Description",
                  hintT: '',
                  isPasswordT: true,
                  isDesciptionT: true,
                ),
                CustomButton(
                  pageCTA: 'Place Order',
                  toSignOrLogin: () {},
                ).afmPadding(EdgeInsets.symmetric(vertical: 10.h))
              ],
            ).afmPadding(
              EdgeInsets.all(
                20.sp,
              ),
            ),
          ),
          Container(
            color: Theme.of(context).cardColor,
            padding: EdgeInsets.all(15.sp),
            child: Column(
              children: [
                Row(
                  children: [
                    ImageIcon(
                      AssetImage(
                        EnvAssets.getIconPath('bell'),
                      ),
                      size: 25.sp,
                    ).afmWrapUp.afmPadding(EdgeInsets.only(right: 10.w)),
                    Text(
                      'Announcements',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ).afmPadding(EdgeInsets.only(
                  bottom: 10.h, /*left: 15.w*/
                )),
                const OrderViews(),
                const OrderViews(),
                const OrderViews(),
                const OrderViews(),
              ],
            ),
          )
              .afmBorderRadius(
                BorderRadius.circular(10.r),
              )
              .afmPadding(
                EdgeInsets.only(
                  left: 20.sp,
                  right: 20.sp,
                  bottom: 20.h,
                ),
              ),
        ],
      ).afmNeverScroll),
    );
  }
}
