import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_transactions_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'package:insta_king/presentation/views/shared_widgets/small_cta.dart';
import 'package:insta_king/presentation/views/transactions/insta_transactions.dart';
import 'package:insta_king/presentation/views/transactions/transactions_view_model.dart';
import 'package:lottie/lottie.dart';

class Deposits extends StatefulWidget {
  const Deposits({super.key});

  @override
  State<Deposits> createState() => _DepositsState();
}

class _DepositsState extends State<Deposits>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40.sp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wallet Deposits',
            style: TextStyle(
              fontFamily: 'Montesserat',
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ).afmPadding(
            EdgeInsets.only(
              bottom: 20.sp,
            ),
          ),
          SizedBox(
            height: 510.h,
            child: Consumer(
              builder: ((context, ref, child) {
                debugPrint(
                    '${ref.read(instaTransactionController).depositData}');
                return ListView.builder(
                  itemCount: ref
                          .read(instaTransactionController)
                          .depositData
                          ?.length ??
                      0,
                  itemBuilder: ((context, index) {
                    return FutureBuilder(
                      future:
                          ref.read(instaTransactionController).getDeposits(),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (ref
                                  .watch(instaTransactionController)
                                  .depositData !=
                              []) {
                            setState(() {});
                            return Container(
                              color: Theme.of(context).cardColor,
                              child: TransactionViewModel(
                                status: Text(ref
                                    .read(instaTransactionController)
                                    .depositModel[index]
                                    .status),
                                type: Text(ref
                                    .read(instaTransactionController)
                                    .depositModel[index]
                                    .type),
                                service: SmallCTA(
                                  width: 70,
                                  height: 20,
                                  text: ref
                                      .read(instaTransactionController)
                                      .depositModel[index]
                                      .service,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.scrim,
                                ).afmBorderRadius(
                                  BorderRadius.circular(5.r),
                                ),
                                trxCode: ref
                                    .read(instaTransactionController)
                                    .depositModel[index]
                                    .trxCode,
                                date: formatDate(ref
                                    .read(instaTransactionController)
                                    .depositModel[index]
                                    .date),
                                amount: ref
                                    .read(instaTransactionController)
                                    .depositModel[index]
                                    .amount,
                                message: ref
                                    .read(instaTransactionController)
                                    .depositModel[index]
                                    .message,
                              ),
                            ).afmBorderRadius(
                              BorderRadius.circular(10.r),
                            );
                          } else {
                            setState(() {});
                            return Lottie.asset(
                              "assets/animation/null-animation.json",
                              controller: _controller,
                              onLoaded: (composition) {
                                _controller
                                  ..duration = composition.duration
                                  ..repeat();
                              },
                            );
                          }
                        } else {
                          return const TransparentLoadingScreen();
                        }
                      }),
                    );
                  }),
                );
              }),
            ),
          )
        ],
      ),
    ).afmPadding(
      EdgeInsets.only(
        bottom: 20.sp,
      ),
    );
  }
}
