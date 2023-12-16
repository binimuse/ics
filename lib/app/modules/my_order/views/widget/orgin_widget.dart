import 'package:flutter/material.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';

class OrginIdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [buildEmpty()],
        ),
      ),
    );
  }

  Widget buildEmpty() {
    return Center(
      child: Container(
        color: AppColors.backgroundLight,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "No Orgin Id Order",
              style: AppTextStyles.titleBold.copyWith(
                color: AppColors.grayDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
