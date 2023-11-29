// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_icon_button.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';

import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_four.dart';

import 'package:ics/app/modules/new_passport/views/widget/steps/step_one.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_three.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_two.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:im_stepper/stepper.dart';
import 'package:sizer/sizer.dart';
import 'package:signature/signature.dart';

import 'package:image_picker/image_picker.dart';

class NewPassportForm extends StatefulWidget {
  @override
  _StepperWithFormExampleState createState() => _StepperWithFormExampleState();
}

class _StepperWithFormExampleState extends State<NewPassportForm> {
  final NewPassportController controller = Get.find<NewPassportController>();
  final ScrollController _scrollController = ScrollController();

  XFile? image;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

  final picker = ImagePicker();
  final int maxSizeInBytes = 50 * 1024 * 1024; // 50 MB
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SizedBox(
              height: 1.h,
            ),
            buildName(context),
            buildForm(context),
            // Spacer(),
          ],
        ),
      ),
    );
  }

  buildForm(BuildContext context) {
    return Container(
      color: AppColors.grayLighter.withOpacity(0.2),
      height: 85.h,
      child: Column(
        children: [
          IconStepper(
            activeStep: controller.currentStep,
            lineColor: AppColors.secondary,
            stepColor: AppColors.grayDefault,
            activeStepColor: AppColors.primary,
            icons: [
              Icon(
                Icons.person,
                color: AppColors.whiteOff,
              ),
              Icon(
                Icons.person,
                color: AppColors.whiteOff,
              ),
              Icon(
                Icons.location_on,
                color: AppColors.whiteOff,
              ),
              Icon(
                Icons.edit_document,
                color: AppColors.whiteOff,
              ),
            ],
            onStepReached: (index) {
              setState(() {
                controller.currentStep = index;
              });
            },
            enableNextPreviousButtons: false,
            enableStepTapping: false,
            stepReachedAnimationDuration: Duration.zero,
          ),
          Obx(() => controller.isfeched.value
              ? Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: FormBuilder(
                      key: controller.newPassportformKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      skipDisabled: true,
                      clearValueOnUnregister: false,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            if (controller.currentStep == 0) Step1(),

                            if (controller.currentStep == 1) Step2(),
                            if (controller.currentStep == 2) Step3(),
                            if (controller.currentStep == 3) Step4(),

                            // Add more form fields as needed for each step
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Center(child: CustomLoadingWidget())),
          Container(
            color: AppColors.whiteOff,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (controller.currentStep > 0)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomNormalButton(
                      text: 'Back',
                      textStyle: AppTextStyles.bodyLargeBold.copyWith(
                        color: AppColors.whiteOff,
                      ),
                      textcolor: AppColors.whiteOff,
                      buttoncolor: controller.areAllTermsSelected()
                          ? AppColors.primary
                          : AppColors.grayLight,
                      borderRadius: AppSizes.radius_16,
                      padding: EdgeInsets.symmetric(
                        vertical: AppSizes.mp_v_1,
                        horizontal: AppSizes.mp_w_6,
                      ),
                      onPressed: () {
                        if (controller.currentStep > 0) {
                          setState(() {
                            controller.currentStep--;
                          });
                        }
                      },
                    ),
                  ),
                Obx(() => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomNormalButton(
                          text: controller.isSendStared.value
                              ? ""
                              : controller.currentStep == 3
                                  ? 'Submit'
                                  : 'Next',
                          textStyle: AppTextStyles.bodyLargeBold.copyWith(
                            color: AppColors.whiteOff,
                          ),
                          rightIcon: controller.isSendStared.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: AppColors.whiteOff,
                                  strokeWidth: 1,
                                ))
                              : SizedBox(),
                          textcolor: AppColors.whiteOff,
                          buttoncolor: controller.currentStep == 3
                              ? AppColors.primary
                              : AppColors.grayLight,
                          borderRadius: AppSizes.radius_16,
                          padding: EdgeInsets.symmetric(
                            vertical: AppSizes.mp_v_1,
                            horizontal: AppSizes.mp_w_6,
                          ),
                          onPressed: () async {
                            if (controller.currentStep == 2) {
                              controller.send();
                              await Future.delayed(const Duration(seconds: 1));
                              // Handle form submission
                              if (controller.isSend.value) {
                                setState(() {
                                  controller.currentStep++;
                                });
                              } else {
                                AppToasts.showError("Some things went wrong");
                              }
                            } else if (controller.currentStep == 3) {
                              controller.checkdoc();
                            } else {
                              if (controller.newPassportformKey.currentState!
                                  .saveAndValidate()) {
                                setState(() {
                                  controller.currentStep++;
                                });
                              } else {
                                _scrollToBottom();
                              }
                            }
                          }),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
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
          'New Passport',
          style: AppTextStyles.bodyLargeBold
              .copyWith(fontSize: AppSizes.font_16, color: AppColors.primary),
        ),
        SizedBox(
          width: 1.w,
        ),
        Text(
          'Application',
          style: AppTextStyles.bodyLargeBold
              .copyWith(fontSize: AppSizes.font_16, color: AppColors.grayDark),
        ),
      ],
    );
  }
}
