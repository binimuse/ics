import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/All_residency/controllers/all_residency_controller.dart';
import 'package:ics/app/modules/All_residency/data/model/residency_appliaction_model.dart';

import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../../../config/theme/app_sizes.dart';

class Step3_Residency extends StatefulWidget {
  final IcsResidencyApplication? citizenModel;
  final AllResidencyController controller;

  const Step3_Residency({
    this.citizenModel,
    required this.controller,
  });
  @override
  State<Step3_Residency> createState() => _Step3State();
}

class _Step3State extends State<Step3_Residency> {
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
            'Passport information',
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
          controller: controller.passport_number,
          hint: 'Passport Number',
          labelText: 'Passport Number',
          validator: ValidationBuilder()
              .required('Passport Number is required')
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
        FormBuilderDateTimePicker(
          name: 'Pasport_Issue_Date',
          initialDate: DateTime.now(),
          lastDate: DateTime.now(),
          initialDatePickerMode: DatePickerMode.year,
          initialValue: widget.citizenModel != null
              ? DateTime.parse(controller.passportIssueDate.text)
              : null,
          onChanged: (value) {
            controller.passportIssueDate.value = TextEditingValue(
              text: value.toString(),
            );
          },
          inputType: InputType.date,
          format: DateFormat('dd/MM/yyyy'),
          enabled: true,
          decoration: ReusableInputDecoration.getDecoration(
              'Pasport Issue Date(GC)',
              isMandatory: true),
          style: AppTextStyles.titleBold.copyWith(
            color: AppColors.blackLight,
            fontSize: AppSizes.font_12,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDateTimePicker(
          name: 'Pasport_Expiry_Date',
          initialDatePickerMode: DatePickerMode.year,
          initialValue: widget.citizenModel != null
              ? DateTime.parse(controller.passportexpiryDate.text)
              : null,
          onChanged: (value) {
            controller.passportexpiryDate.value = TextEditingValue(
              text: value.toString(),
            );
          },
          inputType: InputType.date,
          format: DateFormat('dd/MM/yyyy'),
          enabled: true,
          decoration: ReusableInputDecoration.getDecoration(
              'Pasport Expiry Date(GC)',
              isMandatory: true),
          style: AppTextStyles.titleBold.copyWith(
            color: AppColors.blackLight,
            fontSize: AppSizes.font_12,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          isMandatory: true,
          controller: controller.visa_number,
          hint: 'Visa  Number',
          labelText: 'Visa Number',
          validator:
              ValidationBuilder().required('Visa Number is required').build(),
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
        FormBuilderDateTimePicker(
          name: 'Visa_Issue_Date',
          initialDate: DateTime.now(),
          lastDate: DateTime.now(),
          initialDatePickerMode: DatePickerMode.year,
          initialValue: widget.citizenModel != null
              ? DateTime.parse(controller.workvisaIssueDate.text)
              : null,
          onChanged: (value) {
            controller.workvisaIssueDate.value = TextEditingValue(
              text: value.toString(),
            );
          },
          inputType: InputType.date,
          format: DateFormat('dd/MM/yyyy'),
          enabled: true,
          decoration: ReusableInputDecoration.getDecoration(
              'Work Permit Issue Date/Visa Issue Date(GC)',
              isMandatory: true),
          style: AppTextStyles.titleBold.copyWith(
            color: AppColors.blackLight,
            fontSize: AppSizes.font_12,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}
