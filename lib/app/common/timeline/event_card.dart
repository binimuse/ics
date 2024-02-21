import 'package:flutter/material.dart';
import 'package:ics/app/config/theme/app_colors.dart';

class EventCard extends StatelessWidget {
  final bool isPast;
  final bool? isrejected;
  final child;

  EventCard({
    super.key,
    required this.isPast,
    this.isrejected,
    required this.child,
  });

  Widget build(BuildContext context) {
    Color primaryColor =
        isrejected == true ? AppColors.danger : AppColors.primary;
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: isPast ? primaryColor : AppColors.grayLight,
          borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }
}
