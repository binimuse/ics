// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:ics/app/common/datepicker/date_text_picker_input.dart';
import 'package:ics/app/common/forms/form_lable.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/citizens_model.dart';
import 'package:ics/utils/keyboard.dart';
import 'package:ics/utils/validator_util.dart';
import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';
import 'package:flutter/services.dart';

class Step1 extends StatelessWidget {
  final IcsCitizenModel? citizenModel;
  final NewPassportController controller;

  Step1({
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
            controller: controller.firstNameController,
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
            controller: controller.fatherNameController,
            validator:
                ValidationBuilder().required('Father Name is required').build(),
            hint: 'Father Name',
            labelText: 'Father Name',
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
          TextFormBuilder(
            isMandatory: true,
            controller: controller.grandFatherNameController,
            validator:
                ValidationBuilder().required('Father Name is required').build(),
            hint: 'Grand Father Name',
            labelText: 'Grand Father Name',
            inputFormatters: [
              NoNumberInputFormatter(),
            ],
            showClearButton: false,
            autoFocus: false,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 3.h,
          ),
          FormLabelWidget(
            title: 'Please use Amharic keyboard',
            isRequired: false,
            color: AppColors.primary,
            leftIcon: Icon(
              Icons.keyboard,
              color: AppColors.secondary,
              size: AppSizes.icon_size_6,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          TextFormBuilder(
            isMandatory: true,
            validator:
                ValidationBuilder().required('Father Name is required').build(),
            labelText: "የመጀመሪያ ስም",
            controller: controller.AmfirstNameController,
            inputFormatters: [
              AmharicInputFormatter(),
            ],
            hint: 'የመጀመሪያ ስም',
            showClearButton: false,
            autoFocus: false,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormBuilder(
            isMandatory: true,
            controller: controller.AmfatherNameController,
            validator:
                ValidationBuilder().required('Father Name is required').build(),
            hint: 'የአባት ስም',
            labelText: 'የአባት ስም',
            inputFormatters: [
              AmharicInputFormatter(),
            ],
            showClearButton: false,
            autoFocus: false,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormBuilder(
            isMandatory: true,
            controller: controller.AmgrandFatherNameController,
            validator: ValidationBuilder()
                .required('Grand Father Name is required')
                .build(),
            hint: 'የአያት ስም',
            labelText: 'የአያት ስም',
            inputFormatters: [
              AmharicInputFormatter(),
            ],
            showClearButton: false,
            autoFocus: false,
            onChanged: (value) {},
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
          DateTextPickerInput(
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
          FormBuilderDropdown(
            decoration: ReusableInputDecoration.getDecoration('Nationality'),
            items: controller.natinality.map((CommonModel value) {
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
            name: 'Nationality',
            initialValue:
                citizenModel != null ? controller.natinalityvalue.value! : null,
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
          Text(
            'Is Adoption ?',
            style: AppTextStyles.captionBold.copyWith(
              color: AppColors.grayLight,
              fontSize: AppSizes.font_12,
            ),
          ),
          FormBuilderCheckbox(
            initialValue:
                citizenModel != null ? controller.isAdoption.value : null,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            name: 'Is Adoption',
            title: Text(
              'Is Adoption',
              style: AppTextStyles.captionBold.copyWith(
                color: AppColors.black,
                fontSize: AppSizes.font_12,
              ),
            ),
            activeColor: AppColors.primary,
            onChanged: (value) {
              controller.isAdoption.value = value!;
            },
          )
        ]);
  }

  buildDateOfBirth(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBirthdateField(context),
      ],
    );
  }

  buildBirthdateField(BuildContext context) {
    return TextFormBuilder(
      isMandatory: true,
      controller: controller.dateofbirth,
      validator: ValidationBuilder().required('Birthdate is required').build(),
      hint: 'Birthdate',
      labelText: 'Birthdate',
      showClearButton: false,
      autoFocus: false,
      inputFormatters: [
        DateInputFormatter(),
      ],
      onTap: () {
        KeyboardUtil.hideKeyboard(context);
        // showModal(context);
      },
    );
  }

  DateTime selectedDate = DateTime.now();

  String? formattedDates;
}
