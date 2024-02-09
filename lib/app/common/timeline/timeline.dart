import 'package:flutter/material.dart';
import 'package:ics/app/common/timeline/event_card.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeLineTiles extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final eventchild;
  const MyTimeLineTiles({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.eventchild,
  });

  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle:
          LineStyle(color: isPast ? AppColors.primary : AppColors.grayLight),
      indicatorStyle: IndicatorStyle(
        width: 40,
        color: isPast ? AppColors.primary : AppColors.grayLight,
        iconStyle: IconStyle(
          iconData: Icons.done,
          color: isPast ? Colors.white : AppColors.grayLight,
        ),
      ),
      endChild: EventCard(
        isPast: isPast,
        child: eventchild,
      ),
    );
  }
}
