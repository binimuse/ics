import 'package:get/get.dart';
import 'package:ics/app/modules/home/controllers/home_controller.dart';

import '../controllers/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(
      () => MainPageController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
