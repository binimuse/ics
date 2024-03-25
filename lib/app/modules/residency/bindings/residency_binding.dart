import 'package:get/get.dart';

import '../controllers/residency_controller.dart';

class ResidencyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResidencyController>(
      () => ResidencyController(),
    );
  }
}
