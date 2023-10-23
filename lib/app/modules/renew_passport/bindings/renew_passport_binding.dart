import 'package:get/get.dart';

import '../controllers/renew_passport_controller.dart';

class RenewPassportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RenewPassportController>(
      () => RenewPassportController(),
    );
  }
}
