import 'package:flutter/material.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/gen/assets.gen.dart';

class EmpityWidget extends StatelessWidget {
  final String title;

  EmpityWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.icons.empty,
            color: AppColors.primary,
            width: AppSizes.icon_size_12,
          ),
          Text(
            title,
            style: AppTextStyles.titleBold.copyWith(
                color: AppColors.grayDark, fontSize: AppSizes.font_12),
          ),
        ],
      ),
    );
  }
}
