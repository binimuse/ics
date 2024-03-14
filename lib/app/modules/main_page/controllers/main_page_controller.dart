import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ics/app/modules/home/views/home_view.dart';
import 'package:ics/app/modules/my_order/views/my_order_view.dart';
import 'package:ics/app/modules/notifications/views/notifications_view.dart';
import 'package:ics/app/modules/setting/views/setting_view.dart';

class MainPageController extends GetxController {


  List<Widget> pages = const [
    HomeView(),
    MyOrderView(),
    NotificationsView(),
    SettingView(),
  ];

  final count = 0.obs;

  RxInt selectedViewIndex = 0.obs;
  void changeBottomPage(int i) {
    selectedViewIndex(i);
  }

  /// FOR CHECKING WHEN USER TAPS BACK TWICE TO EXIT APP
  DateTime? currentBackPressTime;

  changescreen(var i) {
    selectedViewIndex.value = i;
  }

  void onInit() {
    super.onInit();

    // Use the latitude and longitude in your MainPageController logic
  }
}
