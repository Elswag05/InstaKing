import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_transactions_controller.dart';
import 'package:insta_king/presentation/views/services/service_widgets.dart';
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
          final trx =
              ref.read(instaTransactionController).instaTransactionsModel;
          ref.read(instaTransactionController.notifier).getTransactions;
          return SafeArea(
            child: Column(
              children: [
                const RecurringAppBar(appBarTitle: 'Transactions').afmPadding(
                  EdgeInsets.only(bottom: 5.h, top: 10.h),
                ),
                const ServicesSearchBar(
                  searchText: 'Search Transactions',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 180.h,
                  child: FutureBuilder(
                    future: ref
                        .read(instaTransactionController.notifier)
                        .getTransactions(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (ref
                                .read(instaTransactionController.notifier)
                                .instaTransactionsModel
                                .data !=
                            null) {
                          // for (int? i = 0; i! < trx.data!.length; i++) {
                          //   numbers.add(i + 1);
                          // }
                          return ListView.builder(
                            itemCount: trx.data?.length,
                            itemBuilder: ((context, index) {
                              return TransactionViewModel(
                                //  no: numbers[index].toString(),
                                status: Text(trx.data?[index].id.toString() ??
                                    'loading...'),
                                type: Text(trx.data?[index].type.toString() ??
                                    'loading...'),
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
