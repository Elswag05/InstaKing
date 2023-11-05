import 'package:flutter/material.dart';
import 'package:insta_king/core/constants/constants.dart';

class InstaProfile extends StatelessWidget {
  const InstaProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: EnvColors.appBackgroundColor,
        body: const Center(child: Text('Profile Page')),
      ),
    );
  }
}
