import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/local/secure_storage_service.dart';
import '../../../data/local/toast_service.dart';
import '../../../main.dart';
import '../../../utils/locator.dart';
import '../../controllers/insta_categories_controller.dart';
import '../../controllers/insta_login_controller.dart';
import '../../controllers/insta_order_controller.dart';
import '../../controllers/insta_profile_controller.dart';
import '../../controllers/insta_transactions_controller.dart';
import '../authentication/login/login.dart';
import 'sub_profile_views.dart/change_password.dart';
import 'sub_profile_views.dart/more_information.dart';
import 'sub_profile_views.dart/profile_details/personal_details_view.dart';
import 'sub_profile_views.dart/refer_and_earn/refer_and_earn.dart';

void navigateToPersonalDetails(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const PersonalDetails(),
    ),
  );
}

void navigateToReferAndEarn(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const ReferAndEarn(),
    ),
  );
}

void navigateToMoreInformation(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const MoreInformation(),
    ),
  );
}

void navigateToChangePassword(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const ChangePassword(),
    ),
  );
}

void handleSignOut(BuildContext context, WidgetRef ref) {
  ref.read(instaLoginController.notifier).signOut().then(
    (value) {
      if (value == true) {
        locator<SecureStorageService>().delete(key: 'token');
        locator<SecureStorageService>().delete(key: 'email');
        navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(
            builder: (context) => const InstaLogin(),
          ),
        );
        Future.delayed(
          Duration.zero,
          () => disposeControllers(ref),
        );
      } else {
        locator<ToastService>().showSuccessToast(
          'Unable to sign you out, please try again later!',
        );
      }
    },
  );
}

void disposeControllers(WidgetRef ref) {
  ref.read(instaTransactionController).disposeTrx();
  ref.read(instaCategoriesController).disposeCategries();
  ref.read(instaProfileController).disposeProf();
  ref.read(instaOrderController).disposeOrders();
}
