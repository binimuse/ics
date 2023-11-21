import 'package:get/get.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:ics/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {
  void logout() async {
    final prefs = await SharedPreferences.getInstance();

    final acc = await prefs.remove(Constants.userAccessTokenKey);
    final id = await prefs.remove(Constants.userId);
    final refreshTokenKey = await prefs.remove('refreshTokenKey');
    final verifyEmail = await prefs.remove(Constants.verifyEmail);

    if (acc && id && refreshTokenKey && verifyEmail) {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
