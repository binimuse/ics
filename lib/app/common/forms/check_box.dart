// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';

import '../../../../gen/assets.gen.dart';

class MyCheckBox extends StatelessWidget {
  const MyCheckBox({
    Key? key,
    required this.isInitSelected,
    required this.checkBoxSize,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  final bool isInitSelected;
  final CheckBoxSize checkBoxSize;
  final ValueChanged<bool> onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isInitSelected);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: getCheckPadding(),
            child: Container(
              decoration: BoxDecoration(
                color: isInitSelected ? AppColors.primary : AppColors.whiteOff,
                borderRadius: BorderRadius.circular(AppSizes.radius_12 * 4),
                border: Border.all(
                  color: isInitSelected
                      ? AppColors.primary
                      : AppColors.grayLighter,
                  width: getBorderWidth(),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppSizes.mp_w_1),
                child: SvgPicture.asset(
                  Assets.icons.check,
                  // ignore: deprecated_member_use
                  color: isInitSelected
                      ? AppColors.whiteOff
                      : AppColors.grayLighter,
                  width: getCheckWidth(),
                ),
              ),
            ),
          ),
          SizedBox(
            width: AppSizes.mp_w_1 / 2,
          ),
          Text(
            text,
            style: getCheckTextStyle(),
          ),
        ],
      ),
    );
  }

  getCheckWidth() {
    if (checkBoxSize == CheckBoxSize.SMALL) {
      return AppSizes.icon_size_4;
    }
    if (checkBoxSize == CheckBoxSize.MEDIUM) {
      return AppSizes.icon_size_6 * 0.8;
    }
    if (checkBoxSize == CheckBoxSize.LARGE) {
      return AppSizes.icon_size_6;
    }
  }

  double getBorderWidth() {
    if (checkBoxSize == CheckBoxSize.SMALL) {
      return 2;
    }
    if (checkBoxSize == CheckBoxSize.MEDIUM) {
      return 1;
    }
    if (checkBoxSize == CheckBoxSize.LARGE) {
      return 2;
    }
    return 2;
  }

  getCheckPadding() {
    if (checkBoxSize == CheckBoxSize.SMALL) {
      return EdgeInsets.all(AppSizes.mp_w_2 * 1.3);
    }
    if (checkBoxSize == CheckBoxSize.MEDIUM) {
      return EdgeInsets.all(AppSizes.mp_w_2 * 1.3);
    }
    if (checkBoxSize == CheckBoxSize.LARGE) {
      return EdgeInsets.all(AppSizes.mp_w_2 * 1.2);
    }
    return EdgeInsets.all(AppSizes.mp_w_2);
  }

  getCheckTextStyle() {
    if (checkBoxSize == CheckBoxSize.SMALL) {
      return AppTextStyles.bodySmallRegular.copyWith(
        color: isInitSelected ? AppColors.grayDark : AppColors.grayDefault,
      );
    }
    if (checkBoxSize == CheckBoxSize.MEDIUM) {
      return AppTextStyles.bodySmallRegular.copyWith(
        color: isInitSelected ? AppColors.grayDark : AppColors.grayDefault,
      );
    }
    if (checkBoxSize == CheckBoxSize.LARGE) {
      return AppTextStyles.bodyLargeBold.copyWith(
        color: isInitSelected ? AppColors.grayDark : AppColors.grayDefault,
      );
    }
    return AppTextStyles.bodySmallRegular.copyWith(
      color: AppColors.grayDefault,
    );
  }
}

enum CheckBoxSize { SMALL, MEDIUM, LARGE }
