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
import 'package:ics/app/modules/renew_origin_id/controllers/renew_origin_id_controller.dart';
import 'package:ics/app/modules/renew_origin_id/data/model/confirmation_model_orginid.dart';
import 'package:ics/app/modules/renew_origin_id/views/widget/profile_view_orginid.dart';

import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReNewOriginIdViewType extends GetView<RenewOriginIdController> {
  const ReNewOriginIdViewType({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
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
                buttoncolor: controller.areAllTermsSelected()
                    ? AppColors.primary
                    : AppColors.grayLight,
                borderRadius: AppSizes.radius_8,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_2,
                  horizontal: AppSizes.mp_w_6,
                ),
                onPressed: () {
                  if (controller.areAllTermsSelected()) {
                    Get.to(() => ProfileViewRenewOrginid());
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
            FutureBuilder<List<ReNewOrginIdConfirmationModel>>(
              future: controller.fetchConfirmationModelCar(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final List<ReNewOrginIdConfirmationModel> confirmationList =
                      snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: confirmationList.length,
                    itemBuilder: (context, index) {
                      final confirmation = confirmationList[index];

                      return Obx(() => GestureDetector(
                            onTap: () {
                              controller.toggleTerm(index);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: AppColors.grayLight.withOpacity(0.9),
                                  width: 1.0,
                                ),
                                color: !controller.isTermChecked(index)
                                    ? Colors.transparent
                                    : AppColors.primary.withOpacity(0.2),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          confirmation.image,
                                          color:
                                              !controller.isTermChecked(index)
                                                  ? AppColors.grayLight
                                                  : AppColors.primary,
                                        ),
                                        SizedBox(width: 3.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              confirmation.name,
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
                                                style: AppTextStyles
                                                    .captionRegular
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
                                      isInitSelected:
                                          controller.isTermChecked(index),
                                      checkBoxSize: CheckBoxSize.MEDIUM,
                                      onChanged: (isChecked) {
                                        controller.toggleTerm(index);
                                      },
                                      text: "",
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ));
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
