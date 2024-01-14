import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/constants/constants.dart';
import 'dart:ui';

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
                        fontSize: 17.sp,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: w / 35),
                    Text(
                      'Sort all your bills here',
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
                Icons.article,
                'Purchase Airtime',
                context,
                const BillAirtime(),
                const Color(0xffFF6D6D),
                Icons.lte_mobiledata_sharp,
                'Buy Data',
                const BillData(),
              ),
              homePageCardsGroup(
                Colors.lightGreen,
                Icons.lightbulb_outline_rounded,
                'Pay Electricity Bills',
                context,
                const BillElectricity(),
                const Color(0xffffa700),
                Icons.live_tv_rounded,
                'Subscribe Cable',
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
      IconData icon,
      String title,
      BuildContext context,
      Widget route,
      Color color2,
      IconData icon2,
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

  Widget homePageCard(Color color, IconData icon, String title,
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
            height: w / 2,
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
                  height: w / 8,
                  width: w / 8,
                  decoration: BoxDecoration(
                    color: color.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: color.withOpacity(.6),
                  ),
                ),
                Text(
                  title,
                  maxLines: 4,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
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




/// homePageCardsGroup(
              //     const Color(0xff63ace5),
              //     Icons.ad_units_outlined,
              //     'Example example example',
              //     context,
              //     const BillAirtime(),
              //     const Color(0xfff37736),
              //     Icons.article_sharp,
              //     'Example example',
              //     const BillAirtime()),
              // homePageCardsGroup(
              //     const Color(0xffFF6D6D),
              //     Icons.android,
              //     'Example example',
              //     context,
              //     const BillAirtime(),
              //     Colors.lightGreen,
              //     Icons.text_format,
              //     'Example',
              //     const BillAirtime()),
              // homePageCardsGroup(
              //     const Color(0xffffa700),
              //     Icons.text_fields,
              //     'Example',
              //     context,
              //     const BillAirtime(),
              //     const Color(0xff63ace5),
              //     Icons.calendar_today_sharp,
              //     'Example example',
              //     const BillAirtime()),