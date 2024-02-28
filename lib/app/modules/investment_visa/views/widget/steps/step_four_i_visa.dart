// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/investment_visa/controllers/investment_visa_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/citizens_model.dart';
import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';

import 'package:flutter/services.dart';

class Step4_I_Visa extends StatefulWidget {
  final IcsApplicationModel? citizenModel;
  final InvestmentVisaController controller;

  const Step4_I_Visa({
    this.citizenModel,
    required this.controller,
  });
  @override
  State<Step4_I_Visa> createState() => _Step3State();
}

class _Step3State extends State<Step4_I_Visa> {
  final InvestmentVisaController controller =
      Get.find<InvestmentVisaController>();

  // other properties go here
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'Step 4',
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
            'Address in Ethiopia',
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
              'Accommodation Type',
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
            controller.accommodationtype.value = value!;
          },
          name: 'Accommodation Type',
          initialValue: widget.citizenModel != null
              ? controller.adresscountryvalue.value
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          isMandatory: true,
          controller: controller.accommodation_name,
          hint: 'Accommodation name',
          labelText: 'Accommodation name',
          validator: ValidationBuilder()
              .required('Accommodation name is required')
              .build(),
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
          controller: controller.accommodation_city,
          hint: 'Accommodation City',
          labelText: 'Accommodation City',
          validator: ValidationBuilder()
              .required('Accommodation City is required')
              .build(),
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
          controller: controller.accommodation_street_address,
          hint: 'Accommodation Street Address',
          labelText: 'Accommodation Street Address',
          validator: ValidationBuilder()
              .required('Accommodation Street Address is required')
              .build(),
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
          controller: controller.accommodation_street_address,
          hint: 'Accommodation Telephone',
          labelText: 'Accommodation Telephone',
          validator: ValidationBuilder()
              .required('Accommodation Telephone is required')
              .build(),
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
