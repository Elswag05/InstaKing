import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/shared_widgets/mini_tags.dart';
import 'package:insta_king/presentation/views/shared_widgets/personal_detail_model_structure.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';

class PlaceOrder extends StatelessWidget {
  const PlaceOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EnvColors.appBackgroundColor,
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
                const PersonalDetailModel(
                  leadTitle: "Link",
                  hintT: 'https://',
                  isPasswordT: true,
                ),
                const PersonalDetailModel(
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
                const PersonalDetailModel(
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
            color: EnvColors.lightColor,
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
                      color: EnvColors.lightColor,
                    ).afmWrapUp.afmPadding(EdgeInsets.only(right: 10.w)),
                    Text(
                      'Announcements',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 16.sp,
                        color: EnvColors.darkColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ).afmPadding(EdgeInsets.only(
                  bottom: 10.h, /*left: 15.w*/
                )),
                Container(
                  color:
                      EnvColors.appBackgroundColor.withBlue(2).withOpacity(0.5),
                  padding: EdgeInsets.all(15.sp),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star_rate_rounded,
                            size: 25.sp,
                            color: EnvColors.lightColor,
                          ).afmWrapUp.afmPadding(EdgeInsets.only(right: 10.w)),
                          SizedBox(
                            width: 150.w,
                            child: Text(
                              'Instagram Service Activated',
                              softWrap: true,
                              style: TextStyle(
                                overflow: TextOverflow.clip,
                                fontFamily: 'Montesserat',
                                fontSize: 14.sp,
                                color: EnvColors.darkColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ).afmPadding(EdgeInsets.only(bottom: 10.h)),
                      Text(
                        'Instagram Service Activated, Thanks for staying with us.',
                        style: TextStyle(
                          fontFamily: 'Montesserat',
                          fontSize: 14.sp,
                          color: EnvColors.darkColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ).afmPadding(EdgeInsets.only(bottom: 15.w)),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            size: 10.sp,
                            color: EnvColors.darkColor,
                          ).afmPadding(EdgeInsets.only(right: 5.w)),
                          Text(
                            '04.10.2023',
                            style: TextStyle(
                              fontFamily: 'Montesserat',
                              fontSize: 10.sp,
                              color: EnvColors.darkColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).afmBorderRadius(
                  BorderRadius.circular(10.r),
                )
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
