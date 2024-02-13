// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/callender/custom_callender.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/renew_origin_id/controllers/renew_origin_id_controller.dart';

import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Step6RenewOrginid extends StatelessWidget {
  final RenewOriginIdController controller =
      Get.find<RenewOriginIdController>();
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
            controller.renewType.name.toString().contains("Correction")
                ? 'schedule appointment here'
                : "Estimated Delivery date is",
            style: AppTextStyles.bodySmallRegular.copyWith(
                fontSize: AppSizes.font_12, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        controller.renewType.name.toString().contains("Correction")
            ? CustomCalendar(
                blackoutDates: controller.occupiedDates,
                minDate: today,
                maxDate: DateTime(today.year, today.month + 3, today.day),
                onTap: (CalendarTapDetails details) {
                  print('Selected date: ${details.date}');
                },
              )
            : SizedBox(
                width: 100.w,
                child: Text(
                  'February/19/2024',
                  style: AppTextStyles.bodyLargeBold.copyWith(
                      fontSize: AppSizes.font_12, color: AppColors.primary),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}
