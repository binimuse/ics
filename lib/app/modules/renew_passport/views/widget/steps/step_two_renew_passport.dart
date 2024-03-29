import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/common/photo_upload/photo_upload.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/renew_passport/controllers/renew_passport_controller.dart';
import 'package:ics/app/modules/renew_passport/data/model/base_model_renew_passport.dart';
import 'package:ics/app/modules/renew_passport/data/model/citizens_model_renew_passport.dart';

import 'package:ics/utils/validator_util.dart';
import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';

class Step2RenewPassport extends StatelessWidget {
  final IcsApplicationModelReNewPassport? citizenModel;
  final RenewPassportController controller;

  const Step2RenewPassport({
    this.citizenModel,
    required this.controller,
  });
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
            'Personal profie',
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
          decoration: ReusableInputDecoration.getDecoration('Occupation',
              isMandatory: false),
          items: controller.occupations.map((CommonModel value) {
            return DropdownMenuItem<CommonModel>(
              value: value,
              child: Text(
                value.name,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.occupationvalue.value = value;
          },
          name: 'Occupation',
          initialValue:
              citizenModel != null ? controller.occupationvalue.value : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration('Hair Color',
              isMandatory: false),
          items: controller.haircolor.map((CommonModel value) {
            return DropdownMenuItem<CommonModel>(
              value: value,
              child: Text(
                value.name,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.haircolorvalue.value = value!;
          },
          name: 'Hair Color',
          initialValue:
              citizenModel != null ? controller.haircolorvalue.value : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration('Eye Color',
              isMandatory: false),
          items: controller.eyecolor.map((CommonModel value) {
            return DropdownMenuItem<CommonModel>(
              value: value,
              child: Text(
                value.name,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.eyecolorvalue.value = value!;
          },
          name: 'Eye Color',
          initialValue:
              citizenModel != null ? controller.eyecolorvalue.value : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration('Skin Color',
              isMandatory: false),
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
          initialValue: citizenModel != null ? citizenModel!.skinColour! : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration('Martial status',
              isMandatory: true),
          validator: (CommonModel? value) {
            if (value == null) {
              return 'Please select a marital status'; // Return an error message if no value is selected
            }
            return null; // Return null if the value is valid
          },
          items: controller.martial.map((CommonModel value) {
            return DropdownMenuItem<CommonModel>(
              value: value,
              child: Text(
                value.name,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.maritalstatusvalue.value = value!;
          },
          name: 'Martial',
          initialValue: citizenModel != null
              ? controller.maritalstatusvalue.value!
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          isMandatory: false,
          inputFormatters: [
            HeightInputFormatter(),
          ],
          controller: controller.height,
          hint: 'Height(cm)',
          keyboardType: TextInputType.number,
          labelText: 'Height(cm)',
          showClearButton: false,
          autoFocus: false,
          onChanged: (value) {},
        ),
        PhotoUpload(
          selectedImages: controller.selectedImages,
          photoPath: controller.photoPath,
        )
      ],
    );
  }
}
