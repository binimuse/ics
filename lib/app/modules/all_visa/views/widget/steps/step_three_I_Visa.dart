import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/all_visa/controllers/all_visa_controller.dart';


import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/citizens_model.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../../../config/theme/app_sizes.dart';

class Step3_I_Visa extends StatefulWidget {
  final IcsApplicationModel? citizenModel;
  final ALLVisaController controller;

  const Step3_I_Visa({
    this.citizenModel,
    required this.controller,
  });
  @override
  State<Step3_I_Visa> createState() => _Step3State();
}

class _Step3State extends State<Step3_I_Visa> {
  final ALLVisaController controller = Get.find<ALLVisaController>();

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
            'Arrival information',
            style: AppTextStyles.bodySmallRegular.copyWith(
                fontSize: AppSizes.font_12, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        FormBuilderDateTimePicker(
          name: 'date_Arrival',
          initialValue: null,
          onChanged: (value) {
            controller.arrivaldDateController.value = TextEditingValue(
              text: value.toString(),
            );
          },
          inputType: InputType.date,
          format: DateFormat('dd/MM/yyyy'),
          enabled: true,
          decoration: ReusableInputDecoration.getDecoration('Arrival  Date(GC)',
              isMandatory: true),
          style: AppTextStyles.titleBold.copyWith(
            color: AppColors.blackLight,
            fontSize: AppSizes.font_12,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration(
              'Departure  Country',
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
            controller.departurecountry.value = value!;
          },
          name: 'Departure  Country',
          initialValue: widget.citizenModel != null
              ? controller.departurecountry.value
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          isMandatory: true,
          controller: controller.departurecity,
          hint: 'Departure City',
          labelText: 'Departure City',
          validator: ValidationBuilder()
              .required('Departure City is required')
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
          isMandatory: false,
          controller: controller.airline,
          hint: 'Airline',
          labelText: 'Airline',
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
          isMandatory: false,
          controller: controller.flight_Number,
          hint: 'Flight Number',
          labelText: 'Flight Number',
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
      ],
    );
  }
}
