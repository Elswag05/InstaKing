import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_assets.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/utils/locator.dart';

class ReferralCopyCard extends StatefulWidget {
  const ReferralCopyCard({super.key});

  @override
  State<ReferralCopyCard> createState() => _ReferralCopyCardState();
}

class _ReferralCopyCardState extends State<ReferralCopyCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final refer = ref.read(instaProfileController.notifier).model;
      return Container(
        color: Theme.of(context).cardColor,
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
                      '${refer.user?.bonus}',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 18.sp,
                      ),
                    ),
                    Text(
                      'Total referrals',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 13.sp,
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
                fontWeight: FontWeight.w500,
              ),
            ).afmPadding(
              EdgeInsets.only(
                bottom: 20.sp,
              ),
            ),
            CollectPersonalDetailModel(
              leadTitle: "Affiliate link",
              hintT: 'https://instaking.ng/signup?ref=${refer.user!.username}',
              isPasswordT: false,
            ),
            CustomButton(
              pageCTA: 'Copy Link',
              toSignOrLogin: () {
                Navigator.pop(context);
                Clipboard.setData(
                  ClipboardData(
                      text:
                          'https://instaking.ng/signup?ref=${refer.user!.username}'),
                ).then(
                  (value) {
                    debugPrint(
                        'data copied successfully ${refer.user!.username}');
                    locator<ToastService>().showSuccessToast(
                      'You have copied you referral link',
                    );
                  },
                );
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
    });
  }
}
