// ignore_for_file: unnecessary_null_comparison

import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/config/theme/app_assets.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:ics/utils/constants.dart';
import 'package:ics/utils/encryption.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final String splasehimage = AppAssets.splasehimage2;

  @override
  void onInit() {
    checkifSignedin();

    super.onInit();
  }

  waitAndNavigate() async {
    bool hasShownToast = false;

    while (true) {
      await Future.delayed(const Duration(seconds: 1));

      final notificationPermissionStatus =
          await requestNotificationPermission();

      if (notificationPermissionStatus == PermissionStatus.granted) {
        checkifSignedin();
        break;
      } else {
        if (!hasShownToast) {
          AppToasts.showError("Please Enable Permissions");
          await openAppSettings();
          hasShownToast = true;
        }
      }
    }
  }

  Future<PermissionStatus> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status;
  }

  void checkifSignedin() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(Constants.userAccessTokenKey) != null) {
      var acc =
          EncryptionUtil.decrypt(prefs.getString(Constants.userAccessTokenKey));

      print(acc);

      final verifyEmail = prefs.getString(Constants.verifyEmail);

      if (acc == null && verifyEmail == null) {
        Future.delayed(const Duration(seconds: 1), () {
          Get.toNamed(Routes.ON_BORDING);
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          Get.toNamed(Routes.MAIN_PAGE);
        });
      }
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Get.toNamed(Routes.ON_BORDING);
      });
    }
  }
}
