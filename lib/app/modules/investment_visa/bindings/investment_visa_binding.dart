import 'package:get/get.dart';

import '../controllers/investment_visa_controller.dart';

class InvestmentVisaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvestmentVisaController>(
      () => InvestmentVisaController(),
    );
  }
}
