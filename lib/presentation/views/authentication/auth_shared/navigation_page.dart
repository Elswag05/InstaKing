import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/views/authentication/login/login.dart';
import 'package:insta_king/presentation/views/authentication/signup/sign_up.dart';
import 'package:insta_king/presentation/views/shared_widgets/cta_button.dart';

class InstaAuthNavigator extends StatelessWidget {
  const InstaAuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Theme.of(context).brightness == Brightness.light
                        ? EnvAssets.getImagePath('instaking-black')
                        : EnvAssets.getImagePath('instaking-white'),
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ],
              ).afmPadding(
                EdgeInsets.only(top: 50.h),
              ),
              Text(
                "Africa's No.1 Social Media\n Marketing Service\n Provider.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
          Column(
            children: [
              CustomButton(
                pageCTA: 'Create Account',
                buttonOnPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
              ).afmPadding(
                EdgeInsets.only(bottom: 10.h),
              ),
              CustomButton(
                pageCTA: 'Log In',
                color: InstaColors.lightColor,
                buttonTextColor: InstaColors.darkColor,
                buttonOnPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InstaLogin(),
                    ),
                  );
                },
              ).afmPadding(
                EdgeInsets.only(bottom: 20.h),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        '''
                      Terms Of Services
                      
    The use of services provided by Instaking establishes agreement to these terms. By registering or using our services you agree that you have read and fully understood the following terms of Service and Instaking will not be held liable for loss in any way for users who have not read the below terms of service!  
SECTION 1.1
                      
  ✔ Instaking does not guarantee a delivery time for any services. We offer our best estimation for when the order will be delivered. This is only an estimation and Instaking will not refund orders that are processing if you feel they are taking too long.
                      
SECTION 1.2
                      
  ✔ We reserve the right to change these terms of service without any notice. You are expected to read all terms of service before placing every order to insure you are up to date with any changes or any future changes.
                      
SECTION 1.3
                      
  ✔ Instaking rates are subject to change at any time without notice. The payment/refund policy stays in effect in the case of rate changes.
                      
SECTION 2
                      
Affiliates
                      
  ✔ If a customer use many accounts then We won't add anything for referral. And affiliates just accept with auto payment, Not manual payment.
                      
2.1
                      
Disclaimers
                      
  ✔ Instaking will not be responsible for any damages you or your business may suffer.
                      
Liabilities
                      
  ✔ Instaking is in no way liable for any account suspension or picture deletion done by Instagram or Twitter or Facebook or YouTube or Other Social Media.
                      
2.2
Refund Policy
                      
  ✔ After a deposit has been completed, No refunds will be made. There is no way to reverse it. You must use your balance on our platform. You agree that once you complete a payment, you will not file a dispute or a chargeback against us for any reason.
                      
  ✔ If you file a dispute or charge-back against us after a deposit, we reserve the right to terminate all of your future orders/ban you from our site.
                      
  ✔ Fraudulent activity such as using unauthorized or stolen credit cards will lead to termination of your account. There are no exceptions.
                      
Privacy Policy
                      
  This policy covers how we use your personal information. We take your privacy seriously and will take all measures to protect your personal information. Any personal information received will only be used to fill your order. We will not sell or redistribute your information to anyone.
                      
Regards,
INSTAKING
                      ''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Montesserat',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ).afmNeverScroll,
                  );
                },
                child: RichText(
                  // Controls visual overflow
                  overflow: TextOverflow.clip,
                  // Controls how the text should be aligned horizontally
                  textAlign: TextAlign.center,
                  // Control the text direction
                  textDirection: TextDirection.rtl,
                  // Whether the text should break at soft line breaks
                  softWrap: true,
                  // Maximum number of lines for the text to span
                  maxLines: 2,
                  // The number of font pixels for each logical pixel
                  textScaler: TextScaler.noScaling,

                  text: TextSpan(
                    text:
                        'By selecting one or the other, you are agreeing\n to our ',
                    style: TextStyle(
                      fontFamily: 'Montesserat',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Terms of Services & Privacy Policy',
                        style: TextStyle(
                          fontFamily: 'Montesserat',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ).afmPadding(
                  EdgeInsets.only(
                    bottom: 20.h,
                    top: 15.h,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
