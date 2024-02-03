import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String title2;
  final String? routeName;
  final bool showLeading;
  final bool showActions;
  final Widget? actionIcon;
  final bool? stoppop;

  CustomAppBar({
    required this.title,
    required this.title2,
    this.routeName,
    this.showLeading = true,
    this.showActions = false,
    this.actionIcon,
    this.stoppop,
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
                stoppop == true ? _showAreYouSureDialog(context) : Get.back();
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

  void _showAreYouSureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: [
                Text(
                  "Are you sure You want to exit ",
                  style: AppTextStyles.bodyLargeBold,
                ),
              ],
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pop(false); // Return false if cancel is pressed
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 5.h,
                width: 25.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                child: Center(
                  child: Text(
                    "Cancel".tr,
                    style: AppTextStyles.bodyLargeBold
                        .copyWith(color: AppColors.whiteOff),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Get.offAllNamed(Routes.MAIN_PAGE);
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 5.h,
                width: 25.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.danger,
                      AppColors.danger,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                child: Center(
                  child: Text(
                    "Yes".tr,
                    style: AppTextStyles.bodyLargeBold
                        .copyWith(color: AppColors.whiteOff),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
