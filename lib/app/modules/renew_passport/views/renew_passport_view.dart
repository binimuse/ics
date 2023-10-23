import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/app_icon_button.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/common/forms/check_box.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/renew_passport/data/model/confirmation_model.dart';
import 'package:ics/app/modules/renew_passport/views/widget/renewpassportform.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

import '../controllers/renew_passport_controller.dart';

class RenewPassportView extends GetView<RenewPassportController> {
  const RenewPassportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteOff,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SizedBox(
              height: 1.h,
            ),
            buildName(context),
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
                    Get.to(() => StepperWithFormExample());
                  } else {
                    AppToasts.showError("Error, Please select all terms");
                  }
                },
              )),
        ],
      ),
    );
  }

  buildName(BuildContext context) {
    return Row(
      children: [
        AppSvgButton(
          imagePath: Assets.icons.arrowleft,
          onPressed: () {
            Get.back();
          },
          size: AppSizes.icon_size_8 * 0.7,
        ),
        Text(
          'ReNew',
          style: AppTextStyles.bodyLargeBold
              .copyWith(fontSize: AppSizes.font_16, color: AppColors.primary),
        ),
        SizedBox(
          width: 1.w,
        ),
        Text(
          'Passport instruction',
          style: AppTextStyles.bodyLargeBold
              .copyWith(fontSize: AppSizes.font_16, color: AppColors.grayDark),
        ),
      ],
    );
  }

  Widget buildAdditionalCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Please ensure that you have the following documents before proceeding.',
              style: AppTextStyles.bodySmallRegular.copyWith(
                color: AppColors.grayDark,
              )),
          SizedBox(height: 2.h),
          FutureBuilder<List<ConfirmationModel>>(
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
                final List<ConfirmationModel> confirmationList = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: confirmationList.length,
                  itemBuilder: (context, index) {
                    final confirmation = confirmationList[index];

                    return Obx(() => Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      confirmation.image,
                                      color: !controller.isTermChecked(index)
                                          ? AppColors.grayLight
                                          : AppColors.primary,
                                    ),
                                    SizedBox(width: 2.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          confirmation.name,
                                          style: AppTextStyles.bodySmallBold
                                              .copyWith(
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
    );
  }
}
