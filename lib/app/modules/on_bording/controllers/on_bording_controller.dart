import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OnBordingController extends GetxController {
  final RxBool isLightTheme = false.obs;

  var isApiLoading = false.obs;
  var hasNetworkError = false.obs;
  var isoptional = true.obs;
  var appversion = "".obs;
  var currentSlide = 0.obs;

  /// List of titles for the on-boarding slides.
  List<String> titles = [
    'Make a Profile',
    'Fill out the Application',
    'Have your document delivered'
  ]; // Add or change this based on your requirement

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  late PageController pageController;
  int currentIndex = 0;

  /// Function called when the current slide is changed.
  onChangedFunction(int index) {
    currentIndex = index;
  }
}
