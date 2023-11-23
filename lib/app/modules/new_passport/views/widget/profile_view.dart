import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/app_icon_button.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/views/widget/newpassportform.dart';

import 'package:ics/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/new_passport_controller.dart';

class ProfileView extends GetView<NewPassportController> {
  const ProfileView({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteOff,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SizedBox(
              height: 1.h,
            ),
            buildName(context),
            buildOrgin(context),
            SquareButton(
              icon: Icons.add,
              onPressed: () {
                // Handle button press here
              },
            ),
            buildActionButtons(),
          ],
        ),
      ),
    );
  }

  buildOrgin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              'Your origin ID is an essential document while living in Ethiopia for identification purposes.',
              style: AppTextStyles.captionRegular.copyWith(
                  fontSize: AppSizes.font_14, color: AppColors.grayDark),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  buildActionButtons() {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        children: [
          Obx(() => CustomNormalButton(
                text: 'Continue',
                textStyle: AppTextStyles.bodyLargeBold.copyWith(
                  color: AppColors.whiteOff,
                ),
                textcolor: AppColors.whiteOff,
                buttoncolor: controller.areAllTermsSelected()
                    ? AppColors.primary
                    : AppColors.grayLight,
                borderRadius: AppSizes.radius_8,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_2,
                  horizontal: AppSizes.mp_w_6,
                ),
                onPressed: () {
                  Get.to(() => NewPassportForm());
                },
              )),
        ],
      ),
    );
  }

  buildName(BuildContext context) {
    return Row(
      children: [
        AppSvgButton(
          imagePath: Assets.icons.arrowleft,
          onPressed: () {
            Get.back();
          },
          size: AppSizes.icon_size_8 * 0.7,
        ),
        Text(
          'Profile ',
          style: AppTextStyles.bodyLargeBold
              .copyWith(fontSize: AppSizes.font_16, color: AppColors.primary),
        ),
        SizedBox(
          width: 1.w,
        ),
        Text(
          'Page',
          style: AppTextStyles.bodyLargeBold
              .copyWith(fontSize: AppSizes.font_16, color: AppColors.grayDark),
        ),
      ],
    );
  }
}

class SquareButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  SquareButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.toastMessageBackground,
        borderRadius: BorderRadius.circular(AppSizes.radius_4),
      ),

      width: 20.w, // Set the desired width of the button
      height: 20.w, // Set the desired height of the button
      child: Icon(icon),
    );
  }
}
