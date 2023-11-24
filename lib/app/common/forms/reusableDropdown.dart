import 'package:flutter/material.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';

class ReusableInputDecoration {
  static InputDecoration getDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.grayLight,
        ),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primary,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.grayLight,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.black,
        ),
      ),
      labelStyle: AppTextStyles.captionBold.copyWith(
        color: AppColors.grayLight,
        fontSize: AppSizes.font_12,
      ),
      contentPadding: EdgeInsets.zero,
      filled: true,
      fillColor: Colors.transparent,
    );
  }
}
