import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/presentation/controllers/insta_login_controller.dart';
import 'package:insta_king/presentation/views/shared_widgets/shared_loading.dart';
import 'profile_widgets/build_profile_content.dart';

class InstaProfile extends ConsumerStatefulWidget {
  const InstaProfile({super.key});

  @override
  ConsumerState<InstaProfile> createState() => _InstaProfileState();
}

class _InstaProfileState extends ConsumerState<InstaProfile> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoadingState loadingState =
        ref.watch(instaLoginController).loadingState;
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          body: Stack(
            children: [
              SafeArea(
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Flexible(
                            flex: 3,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildProfileContent(context, ref),
                  ],
                ),
              ),
              if (loadingState == LoadingState.loading)
                const TransparentLoadingScreen(),
            ],
          ),
        );
      },
    );
  }
}
