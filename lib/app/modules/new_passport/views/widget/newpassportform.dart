import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_icon_button.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/common/forms/text_input.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:im_stepper/stepper.dart';
import 'package:sizer/sizer.dart';

class StepperWithFormExample extends StatefulWidget {
  @override
  _StepperWithFormExampleState createState() => _StepperWithFormExampleState();
}

class _StepperWithFormExampleState extends State<StepperWithFormExample> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final NewPassportController controller = Get.find<NewPassportController>();
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
            buildForm(),
            // Spacer(),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.saveAndValidate()) {
      // Get form data
      Map<String, dynamic> formData = _formKey.currentState!.value;
      // Process form data or submit to an API
      print(formData);
    }
  }

  buildForm() {
    return Container(
      height: 50.h,
      child: Column(
        children: [
          IconStepper(
            activeStep: controller.currentStep,
            activeStepColor: AppColors.primary,
            icons: [
              Icon(
                Icons.person,
                color: AppColors.whiteOff,
              ),
              Icon(
                Icons.location_on,
                color: AppColors.whiteOff,
              ),
              Icon(
                Icons.payment,
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
                key: _formKey,
                child: Column(
                  children: [
                    if (controller.currentStep == 0) buildStep1(),

                    if (controller.currentStep == 1) buildStep2(),
                    if (controller.currentStep == 2) buildStep3(),
                    // Add this line

                    // Add more form fields as needed for each step
                  ],
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
                  borderRadius: AppSizes.radius_8,
                  padding: EdgeInsets.symmetric(
                    vertical: AppSizes.mp_v_2,
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
                borderRadius: AppSizes.radius_8,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_2,
                  horizontal: AppSizes.mp_w_6,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
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
          'New',
          style: AppTextStyles.bodyLargeBold
              .copyWith(fontSize: AppSizes.font_16, color: AppColors.primary),
        ),
        SizedBox(
          width: 1.w,
        ),
        Text(
          'Passport',
          style: AppTextStyles.bodyLargeBold
              .copyWith(fontSize: AppSizes.font_16, color: AppColors.grayDark),
        ),
      ],
    );
  }

  buildStep1() {
    return Column(
      children: [
        TextFormBuilder(
          controller: controller.addressController,
          hint: 'First name',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {
            // Validate password on type

            // Check if the password is valid and display the appropriate text
          },
        ),
        TextFormBuilder(
          controller: controller.addressController,
          hint: 'Last name',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
      ],
    );
  }

  buildStep2() {
    return Column(
      children: [
        TextFormBuilder(
          controller: controller.addressController,
          hint: 'Last name',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        TextFormBuilder(
          controller: controller.addressController,
          hint: 'Enter your Address',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
      ],
    );
  }

  buildStep3() {
    return Column(
      children: [
        TextFormBuilder(
          controller: controller.addressController,
          hint: 'Enter your card number',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        // FormBuilderDropdown(
        //     name: controller.stepFields[controller.currentStep],
        //     decoration: InputDecoration(labelText: 'Select an option'),
        //     validator: FormBuilderValidators.required(),
        //     items: controller.stepOptions[controller.currentStep]
        //         .map((option) => DropdownMenuItem(
        //               value: option.value,
        //               child: Text(option.value),
        //             ))
        //         .toList())
      ],
    );
  }
}
