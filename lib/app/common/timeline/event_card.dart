import 'package:flutter/material.dart';
import 'package:ics/app/config/theme/app_colors.dart';

class EventCard extends StatelessWidget {
  final bool isPast;
  final child;

  EventCard({
    super.key,
    required this.isPast,
    required this.child,
  });

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: isPast ? AppColors.primary : AppColors.grayLight,
          borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }
}
