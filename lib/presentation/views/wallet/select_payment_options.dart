import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_wallet_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';
import 'package:insta_king/presentation/views/shared_widgets/input_data_viewmodel.dart';
import 'package:insta_king/presentation/views/shared_widgets/insta_webview.dart';
import 'package:insta_king/presentation/views/wallet/select_payment_method_containers.dart';

class SelectPaymentOptions extends StatefulWidget {
  final void Function()? onPress;
  const SelectPaymentOptions({super.key, this.onPress});

  @override
  State<SelectPaymentOptions> createState() => _SelectPaymentOptionsState();
}

class _SelectPaymentOptionsState extends State<SelectPaymentOptions> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) {
        return Container(
          color: Theme.of(context).cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Payment Option',
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ).afmPadding(
                EdgeInsets.only(
                  bottom: 5.sp,
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 70.h,
                child: const SelectPaymentContainer().afmPadding(
                  EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                ),
              ),
              CollectPersonalDetailModel(
                leadTitle: 'Amount(NGN)',
                hintT: '500',
                isdigit: [FilteringTextInputFormatter.digitsOnly],
                controller: textEditingController,
                textInputType: TextInputType.number,
              ).afmPadding(
                EdgeInsets.only(
                  bottom: 20.sp,
                ),
              ),
              CustomButton(
                pageCTA: 'Pay',
                buttonOnPressed: () {
                  ref
                      .read(instaWalletController)
                      .toDepositMoney(
                        int.tryParse(textEditingController.text) ?? 0,
                        ref.read(instaWalletController).depositMethodValue,
                      )
                      .then((value) {
                    if (value == true) {
                      debugPrint(
                          'Going to website: ${ref.read(instaWalletController).depositMoneyModel.link}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewKit(
                            linkString: ref
                                    .read(instaWalletController)
                                    .depositMoneyModel
                                    .link ??
                                "https://www.instaking.ng",
                            linkDesc: ref
                                    .read(instaWalletController)
                                    .depositMoneyModel
                                    .message ??
                                'Page Not Found!',
                          ),
                        ),
                      );
                    }
                  });
                  widget.onPress;
                },
              ),
            ],
          ).afmPadding(
            EdgeInsets.all(20.sp),
          ),
        )
            .afmBorderRadius(
              BorderRadius.circular(10.r),
            )
            .afmPadding(
              EdgeInsets.only(bottom: 20.sp, left: 20.sp, right: 20.sp),
            );
      }),
    );
  }
}
