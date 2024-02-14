import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/env_assets.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/local/toast_service.dart';
import 'package:insta_king/presentation/controllers/insta_profile_controller.dart';
import 'package:insta_king/presentation/views/home/home_card_widgets.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/utils/locator.dart';

class ReferralCopyCard extends ConsumerStatefulWidget {
  const ReferralCopyCard({super.key});

  @override
  ConsumerState<ReferralCopyCard> createState() => _ReferralCopyCardState();
}

class _ReferralCopyCardState extends ConsumerState<ReferralCopyCard> {
  @override
  void initState() {
    super.initState();
    ref.read(instaProfileController).getReferralDetails().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final refer = ref.read(instaProfileController).model;
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
                      'Total referrals',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${ref.read(instaProfileController.notifier).refModel.total}',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 18.sp,
                      ),
                    ).afmGetFuture(
                      ref.read(instaProfileController).getReferralDetails(),
                    ),
                    Text(
                      'Affiliate balance',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      formatBalance(refer.user?.bonus ?? '0'),
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 18.sp,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Affiliate link",
                  style: TextStyle(
                    fontFamily: 'Montesserat',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  height: 50.sp,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10.sp),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(
                      10.r,
                    ),
                  ),
                  child: Text(
                    'https://instaking.ng/signup?ref=${refer.user?.username}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                ).afmPadding(
                  EdgeInsets.only(top: 10.sp),
                ),
              ],
            ),
            CustomButton(
              pageCTA: 'Copy Link',
              buttonOnPressed: () {
                Navigator.pop(context);
                Clipboard.setData(
                  ClipboardData(
                      text:
                          'https://instaking.ng/signup?ref=${refer.user?.username}'),
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
