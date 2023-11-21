import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OtpVarificationController extends GetxController {
  var otpverfy = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    otpController = TextEditingController();
    isjustForinit(true);
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

  //mobile varification

  FocusNode otpFocusNode = FocusNode();
  TextEditingController otpController = TextEditingController();
  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());

  var isNextPressedMobile = false.obs;
  var isOtpValid = false.obs;
  var isjustForinit = false.obs;
}
