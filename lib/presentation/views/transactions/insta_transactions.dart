import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/constants/env_colors.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/data/controllers/insta_transactions_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'package:insta_king/presentation/views/shared_widgets/small_cta.dart';
import 'package:insta_king/presentation/views/transactions/transactions_view_model.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class InstaTransactions extends StatefulWidget {
  const InstaTransactions({super.key});

  @override
  State<InstaTransactions> createState() => _InstaTransactionsState();
}

class _InstaTransactionsState extends State<InstaTransactions>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<int> numbers = [];

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
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final tx = ref.read(instaTransactionController);
          final trx =
              ref.read(instaTransactionController).instaTransactionsModel;
          ref.read(instaTransactionController.notifier).getTransactions;
          debugPrint(
              'Next Page ${tx.isThereNextPage} Previous Page ${tx.isTherePreviousPage}');
          return SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const RecurringAppBar(
                      appBarTitle: 'Transactions',
                    ).afmPadding(
                      EdgeInsets.only(
                        top: 10.h,
                      ),
                    ),
                    Row(
                      children: [
                        tx.isTherePreviousPage
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  tx.getPreviousScreen();
                                },
                                child: Icon(
                                  Icons.navigate_before_outlined,
                                  semanticLabel:
                                      'Navigate to previous page url if any',
                                  size: 30.sp,
                                ),
                              )
                            : GestureDetector(
                                child: Icon(
                                  Icons.navigate_before_outlined,
                                  semanticLabel:
                                      'Unable to navigate,  because there is no previous page',
                                  color: InstaColors.mildGrey.withOpacity(0.5),
                                  size: 30.sp,
                                ),
                              ),
                        tx.isThereNextPage
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  tx.getNextScreen();
                                },
                                child: Icon(
                                  Icons.navigate_next_rounded,
                                  semanticLabel: 'Navigate to next page url',
                                  size: 30.sp,
                                ),
                              )
                            : GestureDetector(
                                child: Icon(
                                  Icons.navigate_next_rounded,
                                  semanticLabel:
                                      'Unable to navigate,  because there is no next page',
                                  color: InstaColors.mildGrey.withOpacity(0.5),
                                  size: 30.sp,
                                ),
                              ),
                      ],
                    ).afmPadding(
                      EdgeInsets.only(
                        right: 20.w,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 100.h,
                  child: FutureBuilder(
                    future: ref
                        .read(instaTransactionController.notifier)
                        .getTransactions(tx.instaValue),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (ref
                                .read(instaTransactionController)
                                .instaTransactionsModel
                                .data !=
                            null) {
                          return ListView.builder(
                            itemCount: trx.data?.length,
                            itemBuilder: ((context, index) {
                              return TransactionViewModel(
                                //  no: numbers[index].toString(),
                                // status: Text(trx.data?[index].id.toString() ??
                                //     'loading...'),
                                // type: Text(trx.data?[index].type.toString() ??
                                //     'loading...'),
                                service: SmallCTA(
                                  width: 70.w,
                                  height: 20.h,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.scrim,
                                  text: trx.data?[index].service.toString() ??
                                      'loading...',
                                ).afmBorderRadius(
                                  BorderRadius.circular(5.r),
                                ),
                                trxCode: trx.data?[index].code.toString() ??
                                    'loading...',
                                date: formatDate(
                                    trx.data?[index].createdAt.toString() ??
                                        ''),
                                amount: trx.data?[index].amount.toString() ??
                                    'loading...',
                                message: trx.data?[index].message.toString() ??
                                    'loading...',
                              );
                            }),
                          );
                        } else {
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
                  ),
                ).afmPadding(
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h)),
              ],
            ).afmNeverScroll,
          );
        },
      ),
    );
  }
}

String formatDate(String date) {
  String formattedDateTime = '';
  if (date.isEmpty || date == '') return '';
  try {
    DateTime dateTime = DateTime.parse(date);
    formattedDateTime = DateFormat("dd MMM, yyyy hh:mm:ss a").format(dateTime);
    return formattedDateTime;
  } catch (e) {
    debugPrint('$e');
  }
  return formattedDateTime;
}
