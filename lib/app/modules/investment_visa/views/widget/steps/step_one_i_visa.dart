// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:ics/app/common/datepicker/date_text_picker_input.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/investment_visa/controllers/investment_visa_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/citizens_model.dart';
import 'package:ics/utils/validator_util.dart';
import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';
import 'package:flutter/services.dart';

class Step1_I_Visa extends StatelessWidget {
  final IcsApplicationModel? citizenModel;
  final InvestmentVisaController controller;

  Step1_I_Visa({
    this.citizenModel,
    required this.controller,
  });

  @override

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
              'Step 1',
              style: AppTextStyles.bodyLargeBold.copyWith(
                  fontSize: AppSizes.font_14, color: AppColors.primary),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 1.h,
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
            height: 1.h,
          ),
          TextFormBuilder(
            isMandatory: true,
            validator:
                ValidationBuilder().required('Given name is required').build(),
            labelText: "Given name",
            controller: controller.firstNameController,
            inputFormatters: [
              NoNumberInputFormatter(),
            ],
            hint: 'Given name',
            showClearButton: false,
            autoFocus: false,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormBuilder(
            isMandatory: true,
            controller: controller.fatherNameController,
            validator:
                ValidationBuilder().required('Surname is required').build(),
            hint: 'Surname',
            labelText: 'Surname',
            inputFormatters: [
              NoNumberInputFormatter(),
            ],
            showClearButton: false,
            autoFocus: false,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 2.h,
          ),
          FormBuilderDropdown(
            decoration: ReusableInputDecoration.getDecoration('Gender'),
            items: controller.gender.map((CommonModel value) {
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
              controller.gendervalue.value = value!;
            },
            name: 'Gender',
            initialValue:
                citizenModel != null ? controller.gendervalue.value! : null,
          ),
          SizedBox(
            height: 2.h,
          ),
          FormBuilderDropdown(
            decoration: ReusableInputDecoration.getDecoration('Citizenship'),
            items: controller.bcountries.map((CommonModel value) {
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
              controller.birthCountryvalue.value = value;
            },
            name: 'Citizenship',
            initialValue: citizenModel != null
                ? controller.birthCountryvalue.value!
                : null,
          ),
          SizedBox(
            height: 2.h,
          ),
          FormBuilderDropdown(
            decoration: ReusableInputDecoration.getDecoration('Birth Country'),
            items: controller.bcountries.map((CommonModel value) {
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
              controller.birthCountryvalue.value = value;
            },
            name: 'birth',
            initialValue: citizenModel != null
                ? controller.birthCountryvalue.value!
                : null,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Birth date',
            style: AppTextStyles.captionBold.copyWith(
              color: AppColors.grayLight,
              fontSize: AppSizes.font_12,
            ),
          ),
          DateTextPickerInputReNewPassport(
            yearValidator:
                ValidationBuilder().required('year is required').build(),
            monthValidator:
                ValidationBuilder().required('month is required').build(),
            dateValidator:
                ValidationBuilder().required('date is required').build(),
            controller: controller,
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormBuilder(
            isMandatory: true,
            validator: ValidationBuilder().required('Birth place').build(),
            labelText: "Birth place",
            controller: controller.birthplace,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
            ],
            hint: 'Birth place',
            showClearButton: false,
            autoFocus: false,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormBuilder(
            isMandatory: true,
            validator: ValidationBuilder()
                .required('Email address is required')
                .build(),
            labelText: "Email address",
            controller: controller.emailAdress,
            inputFormatters: [
              NoNumberInputFormatter(),
            ],
            hint: 'Email address',
            showClearButton: false,
            autoFocus: false,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 2.h,
          ),
          FormBuilderDropdown(
            validator: (CommonModel? value) {
              if (value == null) {
                return 'Please select Occupation'; // Return an error message if no value is selected
              }
              return null; // Return null if the value is valid
            },
            decoration: ReusableInputDecoration.getDecoration('Occupation',
                isMandatory: true),
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
                citizenModel != null ? controller.occupationvalue.value! : null,
          ),
        ]);
  }
}
