import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String title2;
  final String? routeName;
  final bool showLeading;
  final bool showActions;
  final Widget? actionIcon;

  CustomAppBar({
    required this.title,
    required this.title2,
    this.routeName,
    this.showLeading = true,
    this.showActions = false,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteOff,
      elevation: 10,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: showLeading
          ? IconButton(
              onPressed: () {
                Get.back();
              },
              padding: EdgeInsets.only(right: AppSizes.mp_w_3),
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.secondary,
                size: AppSizes.icon_size_6,
              ),
            )
          : null,
      title: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(
              title,
              style: AppTextStyles.bodyLargeBold.copyWith(
                  fontSize: AppSizes.font_16, color: AppColors.primary),
            ),
            SizedBox(
              width: 1.w,
            ),
            Text(
              title2,
              style: AppTextStyles.bodyLargeBold.copyWith(
                  fontSize: AppSizes.font_16, color: AppColors.grayDark),
            ),
          ],
        ),
      ),
      actions: showActions
          ? [
              IconButton(
                  onPressed: () {
                    if (routeName != null) {
                      Get.toNamed(routeName!);
                    }
                  },
                  padding: EdgeInsets.only(right: AppSizes.mp_w_3),
                  icon: actionIcon!),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
