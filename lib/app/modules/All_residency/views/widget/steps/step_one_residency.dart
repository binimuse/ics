// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_validator/form_validator.dart';
import 'package:ics/app/common/forms/phone_number_input.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/All_residency/controllers/all_residency_controller.dart';
import 'package:ics/app/modules/All_residency/data/model/residency_appliaction_model.dart';

import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/utils/validator_util.dart';
import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';

class Step1_residency extends StatelessWidget {
  final IcsResidencyApplication? citizenModel;
  final AllResidencyController controller;

  Step1_residency({
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
                ValidationBuilder().required('First Name is required').build(),
            labelText: "First name",
            controller: controller.firstName,
            inputFormatters: [
              NoNumberInputFormatter(),
            ],
            hint: 'First name',
            showClearButton: false,
            autoFocus: false,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormBuilder(
            isMandatory: true,
            validator:
                ValidationBuilder().required('Middle Name is required').build(),
            labelText: "Middle name",
            controller: controller.middleName,
            inputFormatters: [
              NoNumberInputFormatter(),
            ],
            hint: 'Middle name',
            showClearButton: false,
            autoFocus: false,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormBuilder(
            isMandatory: true,
            validator:
                ValidationBuilder().required('Last Name is required').build(),
            labelText: "last name",
            controller: controller.lastName,
            inputFormatters: [
              NoNumberInputFormatter(),
            ],
            hint: 'last name',
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
                citizenModel != null ? controller.gendervalue.value : null,
          ),
          SizedBox(
            height: 2.h,
          ),
          buildPhoneinput(),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormBuilder(
            isMandatory: true,
            validator: ValidationBuilder()
                .required('Email address is required')
                .email('Invalid email address')
                .build(),
            labelText: "Email address",
            controller: controller.emailAdress,
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
                return 'Please select Nationality '; // Return an error message if no value is selected
              }
              return null; // Return null if the value is valid
            },
            decoration: ReusableInputDecoration.getDecoration('Nationality ',
                isMandatory: true),
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
              controller.natinalityvalue.value = value;
            },
            name: 'Nationality ',
            initialValue:
                citizenModel != null ? controller.natinalityvalue.value! : null,
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
          SizedBox(
            height: 2.h,
          ),
        ]);
  }

  buildPhoneinput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: buildCountryCode(),
        ),
        SizedBox(
          width: AppSizes.mp_w_4,
        ),
        Expanded(
          flex: 10,
          child: buildPhonenumber(),
        )
      ],
    );
  }

  buildCountryCode() {
    return CountryCodePicker(
      flagDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.primaryDark,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(3, 3), // changes the shadow position
            ),
          ]),
      onChanged: (element) {
        debugPrint(element.dialCode);

        controller.countryCode = element.dialCode.toString();
      },
      textStyle: AppTextStyles.captionBold,
      initialSelection: 'et',
      textOverflow: TextOverflow.fade,
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
      padding: EdgeInsets.symmetric(vertical: 20),
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
