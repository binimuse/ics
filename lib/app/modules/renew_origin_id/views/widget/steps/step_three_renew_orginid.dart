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
import 'package:ics/app/modules/renew_origin_id/controllers/renew_origin_id_controller.dart';
import 'package:ics/app/modules/renew_origin_id/data/model/base_model_renew_orgin.dart';
import 'package:ics/app/modules/renew_origin_id/data/model/citizens_model_renew_orginId.dart';

import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import '../../../../../config/theme/app_sizes.dart';

class Step3RenewOrginId extends StatefulWidget {
  final IcsCitizenModelReNewOrginId? citizenModel;
  final RenewOriginIdController controller;

  const Step3RenewOrginId({
    this.citizenModel,
    required this.controller,
  });
  @override
  State<Step3RenewOrginId> createState() => _Step3State();
}

class _Step3State extends State<Step3RenewOrginId> {
  final RenewOriginIdController controller =
      Get.find<RenewOriginIdController>();

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
            'Your origin ID is an essential document while living in Ethiopia for identification purposes.',
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
          decoration: ReusableInputDecoration.getDecoration('Country',
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
          name: 'Country',
          initialValue: widget.citizenModel != null
              ? controller.countryvalue.value!
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        Obx(() => controller.isfechedEmbassies.value
            ? FormBuilderDropdown(
                decoration: ReusableInputDecoration.getDecoration('Embassies',
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
                name: 'Embassies',
                initialValue: widget.citizenModel != null
                    ? controller.embassiesvalue.value
                    : null,
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
            FilteringTextInputFormatter.deny(RegExp(r"\s")),
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
