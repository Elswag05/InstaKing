import 'package:flutter/material.dart';

class InstaNitifications extends StatefulWidget {
  const InstaNitifications({super.key});

  @override
  State<InstaNitifications> createState() => _InstaNitificationsState();

  static const notificationRoute = '/notification-screen';
}

class _InstaNitificationsState extends State<InstaNitifications> {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: Column(
        children: [
          Text(message.toString()),
        ],
      ),
    );
  }
}
