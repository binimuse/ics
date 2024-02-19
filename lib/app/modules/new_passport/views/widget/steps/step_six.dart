// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/callender/custom_callender.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:interval_time_picker/interval_time_picker.dart';

class Step6 extends StatelessWidget {
  final NewPassportController controller = Get.find<NewPassportController>();
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
          onTap: (CalendarTapDetails details) {
            controller.selectedDate = details.date!;
            print(controller.selectedDate);

            // Show the time picker with one-hour intervals
            showIntervalTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(DateTime.now()),
              interval: 60,
            ).then((pickedTime) {
              if (pickedTime != null) {
                // Combine the selected date and time
                DateTime selectedDateTime = DateTime(
                  controller.selectedDate!.year,
                  controller.selectedDate!.month,
                  controller.selectedDate!.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );

                // Update your controller or state with the selectedDateTime
                controller.selectedDateTime = selectedDateTime;
              }
            });
          },
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}
