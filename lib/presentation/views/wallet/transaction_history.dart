import 'package:flutter/material.dart';
import 'package:insta_king/presentation/views/wallet/recent_deposits.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            RecentDeposits(),
          ],
        ),
      ),
    );
  }
}
