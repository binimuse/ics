import 'package:get/get.dart';

import '../controllers/renew_origin_id_controller.dart';

class RenewOriginIdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RenewOriginIdController>(
      () => RenewOriginIdController(),
    );
  }
}
