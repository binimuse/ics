import 'package:get/get.dart';

import '../controllers/all_residency_controller.dart';

class AllResidencyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllResidencyController>(
      () => AllResidencyController(),
    );
  }
}
