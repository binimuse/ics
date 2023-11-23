import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/app_icon_button.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/views/widget/newpassportform.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            buildName(context),
            buildOrgin(context),
            buildCard(),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomNormalButton(
              text: 'Add new',
              textStyle: AppTextStyles.bodyLargeBold.copyWith(
                color: AppColors.whiteOff,
              ),
              leftIcon: Icon(
                Icons.add,
                color: AppColors.whiteOff,
                size: AppSizes.icon_size_8 * 0.8,
              ),
              textcolor: AppColors.whiteOff,
              buttoncolor: AppColors.primary,
              borderRadius: AppSizes.radius_8,
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.mp_v_2,
                horizontal: AppSizes.mp_w_6,
              ),
              onPressed: () {
                Get.to(() => NewPassportForm());
              },
            ),
          ),
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

  buildCard() {
    return Expanded(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: AppSizes.mp_v_2 * 1.5),
                    buildCompanyInfoItem(
                      name: "Biniyam",
                      email: "bini@biniyam.com",
                      phone: "0923798644",
                    ),
                    SizedBox(height: AppSizes.mp_v_2 * 1.5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCompanyInfoItem({
    required String name,
    required String email,
    required String phone,
  }) {
    return Container(
      height: 13.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: AppColors.grayLight,
          width: 1.0,
        ),
        color: AppColors.whiteOff,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: AppColors.grayLighter,
            ),
            height: 5.h,
            child: Row(
              children: [
                SizedBox(
                  width: 3.w,
                ),
                SvgPicture.asset(
                  Assets.icons.profile,
                  color: AppColors.grayDark,
                  width: AppSizes.icon_size_6,
                ),
                SizedBox(
                  width: AppSizes.mp_v_1,
                ),
                Text(
                  name,
                  style: AppTextStyles.bodySmallBold.copyWith(
                      color: AppColors.grayDark,
                      fontSize: AppSizes.font_12 * 1.0),
                ),
              ],
            ),
          ),
          SizedBox(
            width: AppSizes.mp_v_4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 9.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  email,
                  style: AppTextStyles.bodySmallRegular.copyWith(
                    color: AppColors.grayDark,
                  ),
                ),
                Text(
                  phone,
                  style: AppTextStyles.bodySmallRegular.copyWith(
                    color: AppColors.grayDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
