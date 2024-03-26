import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/All_residency/controllers/all_residency_controller.dart';
import 'package:ics/app/modules/All_residency/data/model/residency_appliaction_model.dart';

import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';

import 'package:flutter/services.dart';

class Step2_Residency extends StatefulWidget {
  final IcsResidencyApplication? citizenModel;
  final AllResidencyController controller;

  const Step2_Residency({
    this.citizenModel,
    required this.controller,
  });
  @override
  State<Step2_Residency> createState() => _Step3State();
}

class _Step3State extends State<Step2_Residency> {
  final AllResidencyController controller = Get.find<AllResidencyController>();

  // other properties go here
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
            'Address',
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
          decoration: ReusableInputDecoration.getDecoration(
              'Abroad Address Country',
              isMandatory: true),
          items: controller.allwoedCountries.map((AllowedContreyModel value) {
            return DropdownMenuItem<AllowedContreyModel>(
              value: value,
              child: Text(
                value.name,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.abrodcountryvalue.value = value!;
          },
          name: 'Address Country',
          initialValue: widget.citizenModel != null
              ? controller.abrodcountryvalue.value
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          width: 80.w,
          child: Text(
            'Residency Address',
            style: AppTextStyles.bodySmallRegular.copyWith(
                fontSize: AppSizes.font_12, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          isMandatory: true,
          
          controller: controller.localAddressController,
          hint: 'Local Address',
          labelText: 'Local Address',
          validator:
              ValidationBuilder().required('Local Address is required').build(),
          showClearButton: false,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
          ],
          autoFocus: false,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration('Region',
              isMandatory: true),
                validator: FormBuilderValidators.required(),
          items: controller.regsions.map((CommonModel value) {
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
            controller.regionvalue.value = value!;
          },
          name: 'Region',
          initialValue:
              widget.citizenModel != null ? controller.regionvalue.value : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          isMandatory: true,
          controller: controller.woredaContoller,
          hint: 'Woreda',
          labelText: 'Woreda',
          validator: ValidationBuilder().required('Woreda is required').build(),
          showClearButton: false,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
          ],
          autoFocus: false,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          isMandatory: true,
          controller: controller.kebeleContoller,
          hint: 'Kebele',
          labelText: 'Kebele',
          validator: ValidationBuilder().required('Kebele is required').build(),
          showClearButton: false,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
          ],
          autoFocus: false,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
