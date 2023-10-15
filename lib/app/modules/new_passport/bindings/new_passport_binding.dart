import 'package:get/get.dart';

import '../controllers/new_passport_controller.dart';

class NewPassportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPassportController>(
      () => NewPassportController(),
    );
  }
}
