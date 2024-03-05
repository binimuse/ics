import 'package:get/get.dart';


import 'package:ics/app/modules/all_visa/controllers/all_visa_controller.dart';


class AllVisaBinding extends Bindings {

  @override

  void dependencies() {

    Get.lazyPut<ALLVisaController>(

      () => ALLVisaController(),

    );

  }

}

