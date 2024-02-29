import 'package:get/get.dart';

import '../controllers/complain_page_controller.dart';

class ComplainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplainPageController>(
      () => ComplainPageController(),
    );
  }
}
