import 'package:flutter/material.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';

class FormLabelWidget extends StatelessWidget {
  const FormLabelWidget({
    Key? key,
    required this.title,
    required this.isRequired,
    this.leftIcon,
    this.color,
    this.useSmaller,
  }) : super(key: key);

  final String title;
  final bool isRequired;
  final Icon? leftIcon;
  final Color? color;
  final bool? useSmaller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: leftIcon != null
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        leftIcon != null
            ? Padding(
                padding: EdgeInsets.only(right: AppSizes.mp_w_4),
                child: leftIcon!,
              )
            : const SizedBox(),
        Flexible(
          child: Text(
            title,
            style: AppTextStyles.captionBold.copyWith(
              color: AppColors.primary,
              fontSize: AppSizes.font_14,
            ),
          ),
        ),
        SizedBox(width: AppSizes.mp_w_2),
        isRequired
            ? Icon(
                Icons.star,
                size: AppSizes.icon_size_4 * 0.7,
                color: AppColors.primary,
              )
            : const SizedBox(),
      ],
    );
  }
}
