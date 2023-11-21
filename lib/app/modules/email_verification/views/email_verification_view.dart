import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:ics/utils/keyboard.dart';
import 'package:sizer/sizer.dart';

import '../controllers/email_verification_controller.dart';
import 'widgets/dialog_email_resend.dart';

class EmailVerificationView extends GetView<EmailVerificationController> {
  const EmailVerificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Get.toNamed(Routes.QUIZ);
                      },
                      child: Icon(
                        Icons.email_sharp,
                        color: AppColors.primary,
                        size: AppSizes.font_28,
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.mp_v_2,
                    ),
                    Text(
                      "We have sent a confirmation to your e-mail!",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.displayOneRegular,
                    ),
                    SizedBox(
                      height: AppSizes.mp_v_2,
                    ),
                    Material(
                      color: AppColors.primaryLighter,
                      borderRadius: BorderRadius.circular(AppSizes.radius_12),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.mp_w_4 * 1.2,
                          vertical: AppSizes.mp_v_1 * 1.5,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.LOGIN);
                              },
                              child: SizedBox(
                                width: 70.w, // Set a specific width
                                height: 9.h, // Set a specific height
                                child: Center(
                                  child: Text(
                                    "doubled@doubled.com",
                                    textAlign: TextAlign.left,
                                    style: AppTextStyles.titleBold.copyWith(
                                      color: AppColors.primary,
                                      fontSize: AppSizes.font_18,
                                    ),
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.mp_v_2,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSizes.mp_v_2),
                      child: Center(
                        child: Text(
                          "Didn’t get an e-mail?",
                          style: AppTextStyles.bodyLargeBold.copyWith(
                              color: AppColors.grayLight,
                              fontSize: AppSizes.font_16),
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_2),
                    onPressed: () {
                      KeyboardUtil.hideKeyboard(context);
                      Get.dialog(
                        const DialogEmailResend(),
                        barrierDismissible: true,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSizes.mp_v_2),
                      child: Center(
                        child: Text(
                          "Send again",
                          style: AppTextStyles.bodyLargeBold.copyWith(
                              color: AppColors.primary,
                              fontSize: AppSizes.font_14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppSizes.mp_v_4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
