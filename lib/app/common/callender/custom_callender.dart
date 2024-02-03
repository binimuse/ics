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
      monthViewSettings: MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
      ),
      onTap: onTap,
    );
  }
}
