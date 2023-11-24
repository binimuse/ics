import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/utils/validator_util.dart';
import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';
import 'package:flutter/services.dart';

class Step2 extends StatefulWidget {
  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
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
        FormBuilderDropdown(
          validator:
              ValidationBuilder().required('Occupation is required').build(),
          decoration: ReusableInputDecoration.getDecoration('Occupation'),
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
          name: 'Occupation',
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          validator:
              ValidationBuilder().required('Hair Color is required').build(),
          decoration: ReusableInputDecoration.getDecoration('Hair Color'),
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
          name: 'Hair',
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          validator: ValidationBuilder().required('Eye Color').build(),
          decoration: ReusableInputDecoration.getDecoration('Eye Color'),
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
          name: 'Hair',
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          validator: ValidationBuilder().required('Skin Color').build(),
          decoration: ReusableInputDecoration.getDecoration('Skin Color'),
          items: controller.SkinColor.map((String value) {
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
            controller.skincolorvalue.value = value!;
          },
          name: 'Skin',
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          validator: ValidationBuilder()
              .required('Martial status is required')
              .build(),
          decoration: ReusableInputDecoration.getDecoration('Martial status'),
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
          name: 'Martial',
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          inputFormatters: [
            HeightInputFormatter(),
          ],
          controller: controller.height,
          hint: 'Height(cm)',
          keyboardType: TextInputType.number,
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
