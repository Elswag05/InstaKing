import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';

import 'package:insta_king/presentation/views/bill_payment/airtime/bill_airtime.dart';
import 'package:insta_king/presentation/views/bill_payment/cable/bill_cable.dart';
import 'package:insta_king/presentation/views/bill_payment/common_widgets.dart';
import 'package:insta_king/presentation/views/bill_payment/data/bill_data.dart';
import 'package:insta_king/presentation/views/bill_payment/electricity/bill_electricity.dart';

/// Feel free to use the code in your projects
/// but do not forget to give me the credits adding
/// my app (Flutter Animation Gallery) where you are gonna use it.
/// ---------------------------------->>>>>>>>>>>>>>>>>>>>>>>>
class MainBillPayment extends StatefulWidget {
  const MainBillPayment({super.key});

  @override
  MainBillPaymentState createState() => MainBillPaymentState();
}

class MainBillPaymentState extends State<MainBillPayment>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: -30, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          /// ListView
          ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(w / 17, w / 20, 0, w / 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bill Payments',
                      style: TextStyle(
                        fontFamily: 'Montesserat',
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: w / 35),
                    Text(
                      'Sort all your bills in one place',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              homePageCardsGroup(
                const Color(0xfff37736),
                'phone',
                'Airtime',
                context,
                const BillAirtime(),
                const Color(0xffFF6D6D),
                'wifi',
                'Data',
                const BillData(),
              ),
              homePageCardsGroup(
                Colors.lightGreen,
                'flash',
                'Electricity',
                context,
                const BillElectricity(),
                const Color(0xffffa700),
                'monitor',
                'CableTv',
                const BillCable(),
              ),
              SizedBox(height: w / 20),
            ],
          ),

          /// SETTING ICON

          // Blur the Status bar
          blurTheStatusBar(context),
        ],
      ),
    );
  }

  Widget homePageCardsGroup(
      Color color,
      String icon,
      String title,
      BuildContext context,
      Widget route,
      Color color2,
      String icon2,
      String title2,
      Widget route2) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: w / 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          homePageCard(color, icon, title, context, route),
          homePageCard(color2, icon2, title2, context, route2),
        ],
      ),
    );
  }

  Widget homePageCard(Color color, String icon, String title,
      BuildContext context, Widget route) {
    double w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return route;
                },
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            height: w / 2.4,
            width: w / 2.4,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(.15),
                  blurRadius: 7,
                ),
              ],
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(),
                Container(
                  height: w / 7,
                  width: w / 7,
                  decoration: BoxDecoration(
                    color: color.withOpacity(.5),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    EnvAssets.getImagePath(icon),
                    // width: 20.w,
                    // height: 20.h,
                    // ignore: deprecated_member_use
                    color:
                        Theme.of(context).unselectedWidgetColor.withOpacity(.6),
                    semanticLabel: 'Use Fingerprint To Login',
                  ).afmPadding(
                    EdgeInsets.all(10.sp),
                  ),
                  // child: Icon(
                  //   icon,
                  //   color: color.withOpacity(.6),
                  // ),
                ),
                Text(
                  title,
                  maxLines: 4,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
