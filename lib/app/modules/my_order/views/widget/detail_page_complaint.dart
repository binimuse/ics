// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:ics/app/modules/my_order/data/model/ics_complaint_model.dart';

import 'package:sizer/sizer.dart';

class DetailComplaintWidget extends StatelessWidget {
  final BuildContext context;
  final MyOrderController controller;
  final VoidCallback onTap;
  final IcsServiceComplaintModel icsComplain;

  DetailComplaintWidget({
    required this.context,
    required this.onTap,
    required this.controller,
    required this.icsComplain,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        SizedBox(
          height: 30.h,
          width: 100.w, // Set the width to occupy all available space
          child: buildDiscriptionAndRatingForm(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pop(false); // Return false if cancel is pressed
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 25.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                child: Center(
                  child: Text(
                    "Cancel".tr,
                    style: AppTextStyles.bodySmallRegular.copyWith(
                      color: AppColors.whiteOff,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 25.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.danger,
                      AppColors.danger,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                child: Center(
                  child: Text(
                    "Rate".tr,
                    style: AppTextStyles.bodySmallRegular.copyWith(
                      color: AppColors.whiteOff,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  buildDiscriptionAndRatingForm() {
    print(icsComplain.rating);
    print(controller.selectedRating.value);
    icsComplain.rating = controller.selectedRating.value;
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Kindly rate your experience'.tr,
                style: AppTextStyles.bodyLargeBold
                    .copyWith(color: AppColors.black),
              ),
            ),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.sentiment_very_satisfied),
                            color: controller.selectedRating.value == 4
                                ? Colors.green
                                : Colors.grey,
                            onPressed: () {
                              controller.selectedRating.value = 4;
                            },
                          ),
                          Center(
                            child: Text(
                              'Happy'.tr,
                              style: AppTextStyles.bodySmallRegular
                                  .copyWith(color: AppColors.primary),
                            ),
                          ),
                          SizedBox(height: 2.h),
                        ],
                      ),
                      SizedBox(width: 2.w),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.sentiment_satisfied),
                            color: controller.selectedRating.value == 3
                                ? Colors.lightGreen
                                : Colors.grey,
                            onPressed: () {
                              controller.selectedRating.value = 3;
                            },
                          ),
                          Center(
                            child: Text(
                              'Good'.tr,
                              style: AppTextStyles.bodySmallRegular
                                  .copyWith(color: AppColors.primary),
                            ),
                          ),
                          SizedBox(height: 2.h),
                        ],
                      ),
                      SizedBox(width: 2),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.sentiment_neutral),
                            color: controller.selectedRating.value == 2
                                ? Colors.yellow
                                : Colors.grey,
                            onPressed: () {
                              controller.selectedRating.value = 2;
                            },
                          ),
                          Center(
                            child: Text(
                              'Fair'.tr,
                              style: AppTextStyles.bodySmallRegular
                                  .copyWith(color: AppColors.primary),
                            ),
                          ),
                          SizedBox(height: 2.h),
                        ],
                      ),
                      SizedBox(width: 2.w),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.sentiment_dissatisfied),
                            color: controller.selectedRating.value == 1
                                ? Colors.red
                                : Colors.grey,
                            onPressed: () {
                              controller.selectedRating.value = 1;
                            },
                          ),
                          Center(
                            child: Text(
                              'Sad'.tr,
                              style: AppTextStyles.bodySmallRegular
                                  .copyWith(color: AppColors.primary),
                            ),
                          ),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 2.w),
                ],
              ),
            ),
          ],
        ));
  }
}
