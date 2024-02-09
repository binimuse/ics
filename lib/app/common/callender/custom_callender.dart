import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

class CustomCalendar extends StatelessWidget {
  final List<DateTime> blackoutDates;
  final DateTime minDate;
  final DateTime maxDate;
  final Function(CalendarTapDetails) onTap;

  CustomCalendar({
    required this.blackoutDates,
    required this.minDate,
    required this.maxDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      blackoutDates: blackoutDates,
      minDate: minDate,
      maxDate: maxDate,
      appointmentTextStyle: AppTextStyles.bodySmallBold.copyWith(
        color: AppColors.warning,
      ),
      headerStyle: CalendarHeaderStyle(
        textStyle: AppTextStyles.bodySmallBold.copyWith(
          color: AppColors.primary,
        ),
      ),
      monthViewSettings: MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        monthCellStyle: MonthCellStyle(
          backgroundColor: AppColors.whiteOff,
          todayBackgroundColor: AppColors.whiteOff,
          textStyle: AppTextStyles.captionBold.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      onTap: onTap,
      todayTextStyle: AppTextStyles.bodySmallBold.copyWith(
        color: AppColors.whiteOff,
      ),
      todayHighlightColor: AppColors.primary,
      blackoutDatesTextStyle: AppTextStyles.bodyLargeBold.copyWith(
        color: AppColors.danger,
        decoration: TextDecoration.combine([
          TextDecoration.lineThrough,
        ]),
        decorationColor: Colors.black, // Specify the color of the stroke
        decorationThickness: 2, // Specify the thickness of the stroke
      ),
    );
  }
}
