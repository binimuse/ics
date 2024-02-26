import 'package:get/get.dart';
import 'package:ics/app/modules/setting/data/model/configartionmodel.dart';

class TermsAndConditionsController extends GetxController {
  late RxList<BaseSiteConfiguration> baseSiteConfiguration;
  dynamic argumentdata = Get.arguments;
  @override
  void onInit() {
    baseSiteConfiguration = argumentdata["ConfigModel"];

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
