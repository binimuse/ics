// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteOff.withOpacity(0.9),
      child: Center(
        child: SizedBox(
          width: AppSizes.mp_w_12,
          height: AppSizes.mp_w_12,
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 4,
          ),
        ),
      ),
    );
  }
}
