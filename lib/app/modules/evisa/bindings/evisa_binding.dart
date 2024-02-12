import 'package:get/get.dart';

import '../controllers/evisa_controller.dart';

class EvisaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EvisaController>(
      () => EvisaController(),
    );
  }
}
