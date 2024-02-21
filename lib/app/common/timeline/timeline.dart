import 'package:flutter/material.dart';
import 'package:ics/app/common/timeline/event_card.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeLineTiles extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final bool? isrejected;
  final eventchild;
  const MyTimeLineTiles({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    this.isrejected,
    required this.eventchild,
  });

  Widget build(BuildContext context) {
    Color primaryColor =
        isrejected == true ? AppColors.danger : AppColors.primary;
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
        color: isPast ? primaryColor : AppColors.grayLight,
      ),
      indicatorStyle: IndicatorStyle(
        width: 40,
        color: isPast ? primaryColor : AppColors.grayLight,
        iconStyle: IconStyle(
          iconData: Icons.done,
          color: isPast ? Colors.white : AppColors.grayLight,
        ),
      ),
      endChild: EventCard(
        isPast: isPast,
        isrejected: isrejected,
        child: eventchild,
      ),
    );
  }
}
