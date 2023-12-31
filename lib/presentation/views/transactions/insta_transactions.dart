import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_king/core/extensions/widget_extension.dart';
import 'package:insta_king/presentation/controllers/insta_transactions_controller.dart';
import 'package:insta_king/presentation/views/services/service_widgets.dart';
import 'package:insta_king/presentation/views/shared_widgets/recurring_appbar.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'package:insta_king/presentation/views/transactions/transactions_view_model.dart';
import 'package:lottie/lottie.dart';

class InstaTransactions extends StatefulWidget {
  const InstaTransactions({super.key});

  @override
  State<InstaTransactions> createState() => _InstaTransactionsState();
}

class _InstaTransactionsState extends State<InstaTransactions>
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
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final trx = ref
              .read(instaTransactionController.notifier)
              .instaTransactionsModel;
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
                // TransactionViewModel(
                //   no: trx.data?.status ?? 'null',
                //   status: Text(trx.data?.the0?.id?.toString() ?? 'null'),
                //   type: Text(trx.data?.the0?.id?.toString() ?? 'null'),
                //   service: Text(trx.data?.the0?.id?.toString() ?? 'null'),
                //   trxCode: trx.data?.the0?.id?.toString() ?? 'null',
                //   date: trx.data?.the0?.id?.toString() ?? 'null',
                //   amount: trx.data?.the0?.id?.toString() ?? 'null',
                //   message: trx.data?.the0?.id?.toString() ?? 'null',
                // ),
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
                          return ListView.builder(
                            itemCount: 0,
                            itemBuilder: ((context, index) {
                              return TransactionViewModel(
                                no: trx.data?[index].id.toString() ?? '',
                                status:
                                    Text(trx.data?[index].id.toString() ?? ''),
                                type: Text(
                                    trx.data?[index].id.toString() ?? 'null'),
                                service:
                                    Text(trx.data?[index].id.toString() ?? ''),
                                trxCode:
                                    trx.data?[index].id.toString() ?? 'null',
                                date: trx.data?[index].id.toString() ?? 'null',
                                amount:
                                    trx.data?[index].id.toString() ?? 'null',
                                message:
                                    trx.data?[index].id.toString() ?? 'null',
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
