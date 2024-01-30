import 'package:get/get.dart';

import '../controllers/new_origin_id_controller.dart';

class NewOriginIdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewOriginIdController>(
      () => NewOriginIdController(),
    );
  }
}
