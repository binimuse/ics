import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainPageController extends GetxController {
  final GlobalKey<ScaffoldState> keyforall = GlobalKey<ScaffoldState>();

  final count = 0.obs;

  final currentPageIndex = 0.obs;
  void changeBottomPage(int i) {
    currentPageIndex(i);
  }

  /// FOR CHECKING WHEN USER TAPS BACK TWICE TO EXIT APP
  DateTime? currentBackPressTime;

  changescreen(var i) {
    currentPageIndex.value = i;
  }

  void onInit() {
    super.onInit();

    // Use the latitude and longitude in your MainPageController logic
  }
}
