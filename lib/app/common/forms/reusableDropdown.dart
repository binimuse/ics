import 'package:flutter/material.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';

class ReusableInputDecoration {
  static InputDecoration getDecoration(String labelText,
      {bool isMandatory = false}) {
    return InputDecoration(
      label: isMandatory
          ? RichText(
              text: TextSpan(
                text: labelText,
                style: AppTextStyles.titleBold.copyWith(
                  color: AppColors.grayLight,
                  fontSize: AppSizes.font_12,
                ),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            )
          : Text(labelText,
              style: AppTextStyles.captionBold.copyWith(
                color: AppColors.grayLight,
                fontSize: AppSizes.font_12,
              )),
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
      contentPadding: EdgeInsets.zero,
      filled: true,
      fillColor: Colors.transparent,
    );
  }
}
