import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';

import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/all_visa/views/widget/profile_view_i_visa.dart';
import 'package:ics/app/modules/all_visa/controllers/all_visa_controller.dart';

import 'package:sizer/sizer.dart';

import 'package:ics/app/config/theme/app_sizes.dart';

class AllVisaTerms extends StatelessWidget {
  AllVisaTerms({
    super.key,
    required this.isTourst,
    required this.price,
  });

  final bool isTourst;
  final String price;

  final ALLVisaController controller = Get.find<ALLVisaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.baseVisaTypeModel.name.toString(),
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
                !isTourst ? buildAdditionalCard() : SizedBox(),
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
                      controller.isAgreedToTerms.value) {
                    checktheNumber();
                  } else {
                    if (isTourst && controller.isAgreedToTerms.value) {
                      Get.to(ProfileViewInvestmentvisa());
                    } else {
                      AppToasts.showError(
                          " Error, \n Please enter the company \n reference number \n and check the terms");
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
              isMandatory: isTourst ? false : true,
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
          Center(
            child: Text(
              "Visa Fee : \$$price",
              style: AppTextStyles.bodySmallRegular.copyWith(
                color: AppColors.secondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
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
