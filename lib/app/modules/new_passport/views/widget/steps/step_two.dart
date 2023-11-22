import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../../config/theme/app_sizes.dart';

class Step2 extends StatelessWidget {
  final NewPassportController controller = Get.find<NewPassportController>();
  // other properties go here
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'Step 2',
            style: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_14, color: AppColors.primary),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          width: 80.w,
          child: Text(
            'Your passport is an essential document in international travel and for identification purposes. ',
            style: AppTextStyles.bodySmallRegular.copyWith(
                fontSize: AppSizes.font_12, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        ReusableDropdown(
          validator:
              ValidationBuilder().required('Occupation is required').build(),
          labelText: controller.occupationvalue.value.isEmpty
              ? 'Occupation'
              : controller.occupationvalue.value,
          items: controller.occupations.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.occupationvalue.value = value!;
          },
        ),
        SizedBox(
          height: 2.h,
        ),
        ReusableDropdown(
          validator:
              ValidationBuilder().required('Hair Color is required').build(),
          labelText: controller.haircolorvalue.value.isEmpty
              ? 'Hair Color'
              : controller.haircolorvalue.value,
          items: controller.haircolor.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.haircolorvalue.value = value!;
          },
        ),
        SizedBox(
          height: 2.h,
        ),
        ReusableDropdown(
          validator: ValidationBuilder().required('Eye Color').build(),
          labelText: controller.eyecolorvalue.value.isEmpty
              ? 'Eye Color'
              : controller.eyecolorvalue.value,
          items: controller.eyecolor.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.eyecolorvalue.value = value!;
          },
        ),
        SizedBox(
          height: 2.h,
        ),
        ReusableDropdown(
          validator: ValidationBuilder()
              .required('Martial status is required')
              .build(),
          labelText: controller.maritalstatusvalue.value.isEmpty
              ? 'Martial status'
              : controller.maritalstatusvalue.value,
          items: controller.martial.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.maritalstatusvalue.value = value!;
          },
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.height,
          hint: 'Height(cm)',
          labelText: 'Height(cm)',
          validator: ValidationBuilder().required('Height is required').build(),
          showClearButton: false,
          autoFocus: false,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
