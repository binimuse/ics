import 'package:get/get.dart';

import '../controllers/otp_varification_controller.dart';

class OtpVarificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpVarificationController>(
      () => OtpVarificationController(),
    );
  }
}
