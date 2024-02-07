// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/forms/check_box.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/home/data/models/base_renewtype_model.dart';
import 'package:ics/app/modules/renew_passport/controllers/renew_passport_controller.dart';
import 'package:ics/app/modules/renew_passport/views/widget/profile_view_passport.dart';

import 'package:sizer/sizer.dart';

class ReNewPassportViewType extends GetView<RenewPassportController> {
  final ChildType baseOriginIdRenewalType;

  ReNewPassportViewType({
    required this.baseOriginIdRenewalType,
  });

  late List<bool> termCheckedList;

  Widget build(BuildContext context) {
    termCheckedList = List<bool>.generate(
        baseOriginIdRenewalType.originIdRenewalInstructions.length,
        (_) => false).obs;
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.renewType.name,
        title2: "",
        showLeading: true,
      ),
      backgroundColor: AppColors.whiteOff,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SizedBox(
              height: 1.h,
            ),

            buildAdditionalCard(),
            // Spacer(),
            buildActionButtons(),
          ],
        ),
      ),
    );
  }

  buildActionButtons() {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        children: [
          Obx(() => CustomNormalButton(
                text: 'Get on',
                textStyle: AppTextStyles.bodyLargeBold.copyWith(
                  color: AppColors.whiteOff,
                ),
                textcolor: AppColors.whiteOff,
                buttoncolor: areAllTermsSelected()
                    ? AppColors.primary
                    : AppColors.grayLight,
                borderRadius: AppSizes.radius_8,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_2,
                  horizontal: AppSizes.mp_w_6,
                ),
                onPressed: () {
                  if (areAllTermsSelected()) {
                    Get.to(() => ProfileViewRenewPassport());
                  } else {
                    AppToasts.showError("Error, Please select all terms");
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget buildAdditionalCard() {
    return GestureDetector(
      onTap: () {
        // controller.toggleTerm(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Terms and conditions',
                style: AppTextStyles.bodySmallRegular.copyWith(
                  color: AppColors.grayDark,
                )),
            SizedBox(height: 2.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  baseOriginIdRenewalType.originIdRenewalInstructions.length,
              itemBuilder: (context, index) {
                final confirmation =
                    baseOriginIdRenewalType.originIdRenewalInstructions[index];

                return Obx(() => GestureDetector(
                      onTap: () {
                        toggleTerm(index);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: AppColors.grayLight.withOpacity(0.9),
                            width: 1.0,
                          ),
                          color: !isTermChecked(index)
                              ? Colors.transparent
                              : AppColors.primary.withOpacity(0.2),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // SvgPicture.asset(
                                  //   confirmation.image,
                                  //   color: !controller.isTermChecked(index)
                                  //       ? AppColors.grayLight
                                  //       : AppColors.primary,
                                  // ),
                                  SizedBox(width: 3.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        confirmation.title,
                                        style: AppTextStyles.bodySmallBold
                                            .copyWith(
                                          fontSize: 12.sp,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25.h,
                                        child: Text(
                                          overflow: TextOverflow.fade,
                                          maxLines: 6,
                                          confirmation.description,
                                          style: AppTextStyles.captionRegular
                                              .copyWith(
                                            color: AppColors.black,
                                            fontSize: 9.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: MyCheckBox(
                                isInitSelected: isTermChecked(index),
                                checkBoxSize: CheckBoxSize.MEDIUM,
                                onChanged: (isChecked) {
                                  toggleTerm(index);
                                },
                                text: "",
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }

  bool isTermChecked(int index) {
    return termCheckedList[index];
  }

  void toggleTerm(int index) {
    termCheckedList[index] = !termCheckedList[index];
  }

  bool areAllTermsSelected() {
    for (var isChecked in termCheckedList) {
      if (!isChecked) {
        return false;
      }
    }

    return true;
  }
}
