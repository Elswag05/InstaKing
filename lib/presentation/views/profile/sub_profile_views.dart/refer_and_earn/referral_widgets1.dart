import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_assets.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/profile/sub_profile_views.dart/profile_details/personal_detail_model_structure.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';

class ReferralCopyCard extends StatelessWidget {
  const ReferralCopyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: EnvColors.lightColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                EnvAssets.getImagePath('refer_and_earn'),
                width: 60.w,
                height: 60.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      fontSize: 18.sp,
                      color: EnvColors.darkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Total referrals',
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      fontSize: 13.sp,
                      color: EnvColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(
            thickness: 1.dg,
            height: 1.h,
          ).afmPadding(
            EdgeInsets.symmetric(
              vertical: 20.sp,
            ),
          ),
          Text(
            'Every time someone registers an account on instaking using your affiliate link, you get a commission on all their transactions for life',
            style: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 13.sp,
              color: EnvColors.mildGrey,
              fontWeight: FontWeight.w500,
            ),
          ).afmPadding(
            EdgeInsets.only(
              bottom: 20.sp,
            ),
          ),
          const PersonalDetailModel(
            leadTitle: "Affiliate link",
            hintT: 'https://www.affiliate.instaking.store/auth',
            isPasswordT: false,
          ),
          CustomButton(
            pageCTA: 'Copy Link',
            toSignOrLogin: () {
              Navigator.pop(context);
            },
          ).afmPadding(EdgeInsets.symmetric(vertical: 10.h))
        ],
      ).afmPadding(
        EdgeInsets.all(20.sp),
      ),
    )
        .afmBorderRadius(
          BorderRadius.circular(10.r),
        )
        .afmPadding(
          EdgeInsets.all(20.sp),
        );
  }
}
