// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_icon_button.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';

import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_one.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_three.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_two.dart';
import 'package:ics/app/routes/app_pages.dart';
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

  void _submitForm() async {
    AppToasts.showSuccess("Form submitted ,\n check my order page");

    await Future.delayed(const Duration(milliseconds: 400));

    if (controller.newPassportformKey.currentState!.saveAndValidate()) {
      // Get form data
      Map<String, dynamic> formData =
          controller.newPassportformKey.currentState!.value;
      // Process form data or submit to an API
      print(formData);
    }

    Get.offAndToNamed(Routes.MAIN_PAGE);
  }

  buildForm(BuildContext context) {
    return Container(
      height: 80.h,
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
                Icons.edit_document,
                color: AppColors.whiteOff,
              ),
              Icon(
                Icons.location_on,
                color: AppColors.whiteOff,
              ),
            ],
            onStepReached: (index) {
              setState(() {
                controller.currentStep = index;
              });
            },
            enableNextPreviousButtons: false,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: FormBuilder(
                key: controller.newPassportformKey,
                autovalidateMode: AutovalidateMode.disabled,
                clearValueOnUnregister: false,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (controller.currentStep == 0) Step1(),
                      // Add the Step1 class here

                      if (controller.currentStep == 1) Step2(),
                      if (controller.currentStep == 2) Step3(),

                      // Add more form fields as needed for each step
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (controller.currentStep > 0)
                CustomNormalButton(
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
              CustomNormalButton(
                text: controller.currentStep == 2 ? 'Submit' : 'Next',
                textStyle: AppTextStyles.bodyLargeBold.copyWith(
                  color: AppColors.whiteOff,
                ),
                textcolor: AppColors.whiteOff,
                buttoncolor: controller.currentStep == 2
                    ? AppColors.primary
                    : AppColors.grayLight,
                borderRadius: AppSizes.radius_16,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_1,
                  horizontal: AppSizes.mp_w_6,
                ),
                onPressed: () {
                  if (controller.newPassportformKey.currentState!.validate()) {
                    if (controller.currentStep == 2) {
                      // Handle form submission
                      _submitForm();
                    } else {
                      setState(() {
                        controller.currentStep++;
                      });
                    }
                  }
                },
              ),
            ],
          ),
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
