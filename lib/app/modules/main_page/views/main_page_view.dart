// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

import '../controllers/main_page_controller.dart';

class MainPageView extends GetView<MainPageController> {
  const MainPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedViewIndex.value != 0) {
          controller.changescreen(0);
          return false;
        } else {
          DateTime now = DateTime.now();
          if (controller.currentBackPressTime == null ||
              now.difference(controller.currentBackPressTime!) >
                  const Duration(seconds: 2)) {
            //add duration of press gap
            controller.currentBackPressTime = now;
            final snackBar = SnackBar(
              content: Text(
                'Press back again to exit'.tr,
                style: TextStyle(
                  color: AppColors.whiteOff,
                  fontSize: AppSizes.font_10,
                ),
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: AppColors.primary,
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              snackBar,
            ); //scaffold message, you can show Toast message too.
            return false;
          }

          exit(0);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteOff,
        key: controller.keyforall,
        bottomNavigationBar: buildBottomAppBar(context),
        extendBody: false,
        body: Obx(() => controller.pages[controller.selectedViewIndex.value]),
      ),
    );
  }

  Widget buildBottomAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteOff,
          borderRadius: BorderRadius.all(Radius.circular(90)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(3, 3), // changes the shadow position
            ),
          ],
        ),
        child: Stack(clipBehavior: Clip.none, children: [
          BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSizes.mp_v_1, horizontal: AppSizes.mp_v_1),
                  child: WillPopScope(
                    onWillPop: () async {
                      if (controller.selectedViewIndex.value == 0) {
                        // Ask the user if they want to exit the app if they are on the home page
                        exit(0);
                      } else {
                        // Go back to the home page if the user presses the back button on any other page
                        controller.changeBottomPage(0);
                        return false;
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildBottomAppBarButton(
                          Icons.home,
                          "Home".tr,
                          0,
                          context,
                        ),
                        SizedBox(
                          width: AppSizes.mp_w_10,
                        ),
                        buildBottomAppBarButton(
                          Icons.list_alt_outlined,
                          "Reports".tr,
                          1,
                          context,
                        ),
                        SizedBox(
                          width: AppSizes.mp_w_10,
                        ),
                        buildBottomAppBarButton(
                          Icons.notifications,
                          "Notifications".tr,
                          2,
                          context,
                        ),
                        SizedBox(
                          width: AppSizes.mp_w_10,
                        ),
                      ],
                    ),
                  ))),
          Positioned(
            bottom: 45.0,
            right: 40.0,
            child: GestureDetector(
                onTap: () {
                  controller.changeBottomPage(3);
                },
                child: Obx(
                  () => Container(
                    width: 13.w,
                    height: 13.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: controller.selectedViewIndex.value == 3
                          ? AppColors.grayLight
                          : AppColors.primary,
                      boxShadow: [],
                    ),
                    child: buildBottomAppBarButton(
                      Icons.settings,
                      "Setting".tr,
                      3,
                      context,
                    ),
                  ),
                )),
          ),
        ]),
      ),
    );
  }

  Widget buildBottomAppBarButton(
    IconData icon,
    String label,
    int pageIndex,
    BuildContext context,
  ) {
    return SizedBox.fromSize(
        size: const Size(45, 45), // button width and height
        child: InkWell(
          splashColor: Colors.white, // splash color
          onTap: () {
            controller.changeBottomPage(pageIndex);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Obx(() => Icon(
                    icon,
                    color: controller.selectedViewIndex.value == pageIndex
                        ? AppColors.primary
                        : AppColors.grayLight,
                    size: AppSizes.icon_size_4 * 2,
                  )),
            ],
          ),
        ));
  }
}
