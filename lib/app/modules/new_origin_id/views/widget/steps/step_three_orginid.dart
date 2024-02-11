import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/phone_number_input.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_origin_id/controllers/new_origin_id_controller.dart';
import 'package:ics/app/modules/new_origin_id/data/model/citizens_model_orginId.dart';

import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import '../../../../../config/theme/app_sizes.dart';
import '../../../data/model/base_model_orgin.dart';

class Step3OrginId extends StatefulWidget {
  final IcsCitizenModelOrginId? citizenModel;
  final NewOriginIdController controller;

  const Step3OrginId({
    this.citizenModel,
    required this.controller,
  });
  @override
  State<Step3OrginId> createState() => _Step3State();
}

class _Step3State extends State<Step3OrginId> {
  final NewOriginIdController controller = Get.find<NewOriginIdController>();

  // other properties go here
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'Step 3',
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
            'Address and collaction Information',
            style: AppTextStyles.bodySmallRegular.copyWith(
                fontSize: AppSizes.font_12, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration('Current Country',
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
            controller.currentcountryvalue.value = value!;
          },
          name: 'Current Country',
          initialValue: widget.citizenModel!.newOriginIdApplications.isNotEmpty
              ? controller.currentcountryvalue.value!
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration(
              'Collaction Country',
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
            controller.countryvalue.value = value!;
            setState(() {
              controller.getEmbassies(controller.countryvalue.value!.id);
              controller.embassiesvalue.value = null;
            });
          },
          name: 'Collaction Country',
          initialValue: widget.citizenModel != null
              ? controller.countryvalue.value!
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        Obx(() => controller.isfechedEmbassies.value
            ? FormBuilderDropdown(
                decoration: ReusableInputDecoration.getDecoration(
                    'Embassies/branch',
                    isMandatory: true),
                items: controller.base_embassies.map((CommonModel value) {
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
                  controller.embassiesvalue.value = value;
                },
                validator: FormBuilderValidators.required(),
                name: 'Embassies/branch',
              )
            : SizedBox()),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          isMandatory: true,
          controller: controller.addressController,
          hint: 'Street details/Address line 1',
          labelText: 'Address',
          validator:
              ValidationBuilder().required('Address is required').build(),
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
        buildPhonenumber(),
      ],
    );
  }

  buildPhonenumber() {
    return PhoneNumberInput(
      isMandatory: true,
      hint: 'Phone number',
      labelText: "Phone number",
      focusNode: controller.phoneFocusNode,
      autofocus: false,
      controller: controller.phonenumber,
      onChanged: (value) {
        // Validate password on type
        bool isValid =
            controller.validatPhone(); // Pass the value to validatePassword
        controller.isPhoneValid.value = isValid;

        // Check if the password is valid and display the appropriate text
      },
      validator: FormBuilderValidators.required(),
    );
  }
}
