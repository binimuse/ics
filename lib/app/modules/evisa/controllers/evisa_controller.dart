import 'package:get/get.dart';

class EvisaController extends GetxController {
  final List<String> evisaType = [
    'Work Visa',
    'Tourist Visa',
    'Investment Visa',
    'Government Work Visa',
    'NGO Visa',
    'Private Work Visa',
    'Journalist Visa',
    'Workshop/ Conference Visa',
  ];

  final count = 0.obs;

  @override
  void onInit() {
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

  void increment() => count.value++;
}
