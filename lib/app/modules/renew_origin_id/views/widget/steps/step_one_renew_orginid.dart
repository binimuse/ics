// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/datepicker/date_text_picker_input.dart';

import 'package:ics/app/common/forms/form_lable.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/renew_origin_id/controllers/renew_origin_id_controller.dart';
import 'package:ics/app/modules/renew_origin_id/data/model/base_model_renew_orgin.dart';
import 'package:ics/app/modules/renew_origin_id/data/model/citizens_model_renew_orginId.dart';
import 'package:flutter/services.dart';
import 'package:ics/utils/keyboard.dart';
import 'package:ics/utils/validator_util.dart';
import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';

class Step1RenewOrginId extends StatelessWidget {
  final IcsApplicationModelReNewOrginId? citizenModel;
  final RenewOriginIdController controller;

  Step1RenewOrginId({
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
          firstName(),
          SizedBox(
            height: 2.h,
          ),
          fatherName(),
          SizedBox(
            height: 2.h,
          ),
          gfathername(),
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
          firstNameAm(),
          SizedBox(
            height: 2.h,
          ),
          fatherNameAm(),
          SizedBox(
            height: 2.h,
          ),
          gFathernameAm(),
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
          bithDay(),
          SizedBox(
            height: 2.h,
          ),
          gender(),
          SizedBox(
            height: 2.h,
          ),
          natianlity(),
          SizedBox(
            height: 2.h,
          ),
          countery(),
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
          Obx(() => controller.showAdoption.value
              ? Text(
                  'Is Adoption ?',
                  style: AppTextStyles.captionBold.copyWith(
                    color: AppColors.grayLight,
                    fontSize: AppSizes.font_12,
                  ),
                )
              : SizedBox()),
          Obx(() => controller.showAdoption.value ? adobation() : SizedBox())
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

  firstName() {
    return TextFormBuilder(
      isMandatory: true,
      validator: ValidationBuilder().required('First Name is required').build(),
      labelText: "First name",
      controller: controller.firstNameController,
      inputFormatters: [
        NoNumberInputFormatter(),
      ],
      hint: 'First name',
      showClearButton: false,
      autoFocus: false,
      onChanged: (value) {},
    );
  }

  fatherName() {
    return TextFormBuilder(
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
    );
  }

  gfathername() {
    return TextFormBuilder(
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
    );
  }

  firstNameAm() {
    return TextFormBuilder(
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
    );
  }

  fatherNameAm() {
    return TextFormBuilder(
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
    );
  }

  gFathernameAm() {
    return TextFormBuilder(
      isMandatory: true,
      controller: controller.AmgrandFatherNameController,
      validator:
          ValidationBuilder().required('Grand Father Name is required').build(),
      hint: 'የአያት ስም',
      labelText: 'የአያት ስም',
      inputFormatters: [
        AmharicInputFormatter(),
      ],
      showClearButton: false,
      autoFocus: false,
      onChanged: (value) {},
    );
  }

  bithDay() {
    return DateTextPickerInputReNewPassport(
      yearValidator: ValidationBuilder().required('year is required').build(),
      monthValidator: ValidationBuilder().required('month is required').build(),
      dateValidator: ValidationBuilder().required('date is required').build(),
      controller: controller,
    );
  }

  natianlity() {
    return FormBuilderDropdown(
      decoration: ReusableInputDecoration.getDecoration('Nationality',
          isMandatory: true),
      items: controller.natinality.map((CommonModel value) {
        return DropdownMenuItem<CommonModel>(
          value: value,
          child: Text(
            value.name,
            style:
                AppTextStyles.captionBold.copyWith(color: AppColors.grayDark),
          ),
        );
      }).toList(),
      onChanged: (value) {
        controller.natinalityvalue.value = value;
      },
      name: 'Nationality',
      initialValue:
          citizenModel != null ? controller.natinalityvalue.value! : null,
    );
  }

  gender() {
    return FormBuilderDropdown(
      decoration:
          ReusableInputDecoration.getDecoration('Gender', isMandatory: true),
      items: controller.gender.map((CommonModel value) {
        return DropdownMenuItem<CommonModel>(
          value: value,
          child: Text(
            value.name,
            style:
                AppTextStyles.captionBold.copyWith(color: AppColors.grayDark),
          ),
        );
      }).toList(),
      onChanged: (value) {
        controller.gendervalue.value = value!;
      },
      name: 'Gender',
      initialValue: citizenModel != null ? controller.gendervalue.value! : null,
    );
  }

  countery() {
    return FormBuilderDropdown(
      decoration: ReusableInputDecoration.getDecoration('Birth Country',
          isMandatory: true),
      items: controller.bcountries.map((CommonModel value) {
        return DropdownMenuItem<CommonModel>(
          value: value,
          child: Text(
            value.name,
            style:
                AppTextStyles.captionBold.copyWith(color: AppColors.grayDark),
          ),
        );
      }).toList(),
      onChanged: (value) {
        controller.birthCountryvalue.value = value;
      },
      name: 'birth',
      initialValue:
          citizenModel != null ? controller.birthCountryvalue.value! : null,
    );
  }

  adobation() {
    return FormBuilderCheckbox(
      initialValue: citizenModel != null ? controller.isAdoption.value : null,
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
    );
  }
}
