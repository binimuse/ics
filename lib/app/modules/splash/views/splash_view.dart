import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: AppColors.whiteOff,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  controller.splasehimage,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
