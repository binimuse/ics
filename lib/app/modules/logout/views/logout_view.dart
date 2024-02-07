import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'package:ics/app/config/theme/app_assets.dart';


import 'package:ics/app/config/theme/app_colors.dart';


import 'package:ics/app/config/theme/app_text_styles.dart';


import 'package:sizer/sizer.dart';


import '../controllers/logout_controller.dart';


class LogoutView extends GetView<LogoutController> {

  LogoutView({Key? key}) : super(key: key);


  final LogoutController logoutController = Get.put(LogoutController());


  @override

  Widget build(BuildContext context) {

    return Dialog(

      backgroundColor: Colors.transparent,

      child: ClipRect(

        child: Center(

          child: Container(

            alignment: Alignment.center,

            padding: const EdgeInsets.symmetric(horizontal: 15),

            margin: const EdgeInsets.symmetric(horizontal: 15),

            height: 42.h,

            width: 80.w,

            decoration: BoxDecoration(

                color: Colors.white,

                boxShadow: [

                  BoxShadow(

                    offset: const Offset(1, 1),

                    spreadRadius: 5,

                    blurRadius: 10,

                    color: Colors.grey.withOpacity(0.9),

                  ),

                ],

                borderRadius: const BorderRadius.all(Radius.circular(15))),

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                ClipRRect(

                  borderRadius: BorderRadius.circular(4.0),

                  child: Image.asset(

                    AppAssets.splasehimage2,

                    width: 70.w,

                    height: 30.w,

                    fit: BoxFit.contain,

                  ),

                ),

                Container(

                  padding: const EdgeInsets.symmetric(vertical: 2),

                  child: Text(

                    "Log out".tr,

                    style: AppTextStyles.bodyLargeBold,

                  ),

                ),

                Container(

                  padding:

                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),

                  child: Text(

                    "Are you sure you want to log out?".tr,

                    textAlign: TextAlign.center,

                    style: AppTextStyles.captionRegular,

                  ),

                ),

                SizedBox(

                  height: 2.h,

                ),

                Row(

                  crossAxisAlignment: CrossAxisAlignment.center,

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    GestureDetector(

                      onTap: () {

                        Navigator.pop(context);

                      },

                      child: Container(

                          alignment: Alignment.center,

                          margin: const EdgeInsets.symmetric(vertical: 5),

                          padding: const EdgeInsets.symmetric(horizontal: 15),

                          height: 4.h,

                          width: 27.w,

                          decoration: BoxDecoration(

                              gradient: LinearGradient(

                                colors: [

                                  AppColors.primary,

                                  AppColors.primary,

                                ],

                                begin: Alignment.centerLeft,

                                end: Alignment.centerRight,

                              ),

                              borderRadius:

                                  BorderRadius.all(Radius.circular(22))),

                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [

                              Text(

                                "cancel".tr,

                                style: AppTextStyles.bodySmallBold

                                    .copyWith(color: AppColors.whiteOff),

                              ),

                            ],

                          )),

                    ),

                    SizedBox(

                      width: 2.w,

                    ),

                    GestureDetector(

                      onTap: () {

                        logoutController.logout();


                        Navigator.pop(context);

                      },

                      child: Container(

                          alignment: Alignment.center,

                          margin: const EdgeInsets.symmetric(vertical: 5),

                          padding: const EdgeInsets.symmetric(horizontal: 15),

                          height: 4.h,

                          width: 27.w,

                          decoration: const BoxDecoration(

                              gradient: LinearGradient(

                                colors: [Colors.red, Colors.red],

                                begin: Alignment.centerLeft,

                                end: Alignment.centerRight,

                              ),

                              borderRadius:

                                  BorderRadius.all(Radius.circular(22))),

                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [

                              Text(

                                "ok".tr,

                                style: AppTextStyles.bodySmallBold

                                    .copyWith(color: AppColors.whiteOff),

                              ),

                            ],

                          )),

                    ),

                  ],

                ),

              ],

            ),

          ),

        ),

      ),

    );

  }

}

