// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_origin_id/controllers/new_origin_id_controller.dart';

import 'package:sizer/sizer.dart';
import '../../../../../common/callender/custom_callender.dart';
import '../../../../../config/theme/app_sizes.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Step6Orginid extends StatelessWidget {
  final NewOriginIdController controller = Get.find<NewOriginIdController>();
  // other properties go here

  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20.w,
          child: Text(
            'Step 6',
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
          child: Text(
            'schedule appointment here',
            style: AppTextStyles.bodySmallRegular.copyWith(
                fontSize: AppSizes.font_12, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        CustomCalendar(
          blackoutDates: controller.occupiedDates,
          minDate: today,
          maxDate: DateTime(today.year, today.month + 3, today.day),
          onTap: (CalendarTapDetails details) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          validator: ValidationBuilder().required('Urgency type').build(),
          decoration: ReusableInputDecoration.getDecoration('Urgency type',
              isMandatory: true),
          items: controller.urgencytype.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            //  controller.skincolorvalue.value = value!;
          },
          name: 'Urgency',
          //  initialValue: citizenModel != null ? citizenModel!.skinColour! : null,
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}
