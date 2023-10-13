import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/config/theme/app_assets.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  final String splasehimage = AppAssets.splasehimage2;

  @override
  void onInit() {
    waitAndNavigate();

    super.onInit();
  }

  waitAndNavigate() async {
    bool hasShownToast = false;

    while (true) {
      await Future.delayed(const Duration(seconds: 1));

      final notificationPermissionStatus =
          await requestNotificationPermission();

      if (notificationPermissionStatus == PermissionStatus.granted) {
        Get.offAllNamed(Routes.ON_BORDING);
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
}
