import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/All_residency/views/widget/profile_view_residency.dart';
import 'package:ics/app/modules/new_origin_id/data/model/confirmation_model_orginid.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/all_residency_controller.dart';

class AllResidencyView extends GetView<AllResidencyController> {
  AllResidencyView({Key? key}) : super(key: key);
  final AllResidencyController controller = Get.find<AllResidencyController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.baseResidencyTypeModel.name.toString(),
        title2: "Terms",
        showLeading: true,
      ),
      backgroundColor: AppColors.whiteOff,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                controller.baseResidencyTypeModel.name == "Work residency"
                    ? buildAdditionalCard()
                    : buildTermCard(),
                Expanded(
                  child: SizedBox(),
                ),
                buildCheckboxFormField(),
                buildActionButtons(),
              ],
            ),
          ),
          Obx(() => controller.networkStatus.value == NetworkStatus.LOADING
              ? Center(child: CustomLoadingWidget())
              : SizedBox()),
        ],
      ),
    );
  }

  Widget buildTermCard() {
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
            FutureBuilder<List<NewOrginIdConfirmationModel>>(
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
                  final List<NewOrginIdConfirmationModel> confirmationList =
                      snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: confirmationList.length,
                    itemBuilder: (context, index) {
                      final confirmation = confirmationList[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: AppColors.grayLight.withOpacity(0.9),
                              width: 1.0,
                            ),
                            color: Colors.transparent),
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
                                  SvgPicture.asset(confirmation.image,
                                      color: AppColors.grayLight),
                                  SizedBox(width: 3.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                          ],
                        ),
                      );
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
                buttoncolor: controller.isAgreedToTerms.value
                    ? AppColors.primary
                    : AppColors.grayLight,
                borderRadius: AppSizes.radius_8,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_2,
                  horizontal: AppSizes.mp_w_6,
                ),
                onPressed: () {
                  if (controller.companyreference.text.isNotEmpty &&
                      controller.isAgreedToTerms.value &&
                      controller.baseResidencyTypeModel.name ==
                          "Work residency") {
                    checktheNumber();
                  } else {
                    if (controller.isAgreedToTerms.value) {
                      Get.to(ProfileViewResidency());
                    }
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget buildAdditionalCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Please ensure that you input Company Reference number',
              style: AppTextStyles.bodySmallRegular.copyWith(
                color: AppColors.grayDark,
              )),
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormBuilder(
              isMandatory: true,
              controller: controller.companyreference,
              hint: 'Company Reference number',
              labelText: 'Company Reference number',
              validator: ValidationBuilder()
                  .required('Company Reference number is required')
                  .build(),
              showClearButton: false,
              autoFocus: false,
              onChanged: (value) {},
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.info,
                  size: 19.2,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(
                width: 70.w,
                child: Text(
                  'How to create Company Reference number?',
                  style: AppTextStyles.bodySmallUnderlineRegular
                      .copyWith(fontSize: 14),
                ),
              ),
              SizedBox(
                width: 2.h,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCheckboxFormField() {
    return Obx(() => CheckboxListTile(
          title: InkWell(
            onTap: () {
              // Perform navigation to the terms and conditions screen here

              // Example: Get.to(TermsAndConditionsScreen());
            },
            child: Text(
              'I agree to the terms and conditions',
              style: AppTextStyles.titleBold.copyWith(
                color: AppColors.blackLight,
                fontSize: AppSizes.font_12,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          activeColor: AppColors.primary,
          value: controller.isAgreedToTerms.value,
          onChanged: (value) {
            controller.isAgreedToTerms.value = value!;
          },
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ));
  }

  void checktheNumber() async {
    await controller.checkTheNumber();
  }
}
