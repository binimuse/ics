
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/button/button_gray_scale_outline_without_icon.dart';
import 'package:ics/app/common/button/button_primary_fill.dart';
import 'package:ics/app/common/navigation/top_nav_close_text.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../controllers/otp_varification_controller.dart';

class OtpVarificationView extends GetView<OtpVarificationController> {
  const OtpVarificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///APP BAR
            const TopNavCloseText(
              centerTitle: '',
              rightText: '',
              useHomeIcon: false,
            ),

            SizedBox(
              height: 1.h,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Otp verification",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.displayOneBold
                            .copyWith(fontSize: AppSizes.font_10),
                      ),
                      SizedBox(
                        height: AppSizes.mp_v_1,
                      ),
                      Text(
                        "Please Input the OTP we sent to Your Email Address",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.bodySmallRegular.copyWith(
                            color: AppColors.grayDark,
                            fontSize: AppSizes.font_10),
                      ),
                      SizedBox(
                        height: AppSizes.mp_v_1,
                      ),
                      SizedBox(
                        height: AppSizes.mp_v_1,
                      ),
                      buildOTPNumber(context),
                      SizedBox(
                        height: AppSizes.mp_v_1,
                      ),
                      Obx(() => !controller.resendotpstarted.value
                          ? Align(
                              alignment: Alignment.topLeft,
                              child: ButtonGrayScaleOutlineWithOutIcon(
                                  buttonSizeType: ButtonSizeType.SMALL,
                                  text: !controller.makeButtonEnable.value
                                      ? 'Resend in ' +
                                          controller.countdownValue.value
                                              .toString() +
                                          ' seconds'
                                      : 'Resend',
                                  onTap: () {
                                    if (controller.makeButtonEnable.value) {
                                      controller.resendOtp();
                                    }
                                  },
                                  isDisabled: controller.makeButtonEnable.value
                                      ? false
                                      : true),
                            )
                          : Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.primary),
                                ),
                              ),
                            )),
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Column(
              children: [
                Obx(() => controller.verificationOtp.isFalse
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.mp_w_8,
                        ),
                        child: ButtonPrimaryFill(
                          isterms: false,
                          buttonSizeType: ButtonSizeType.LARGE,
                          isDisabled: !controller.isOtpValid.value,
                          text: !controller.isOtpValid.value
                              ? "Enter your OTP number"
                              : "Done",
                          onTap: () {
                            if (!controller.isOtpValid.value) {
                              // Logic for when the "Enter 6-digit code" button is pressed
                            } else {
                              controller.verification();
                              //  Get.toNamed(Routes.EMAIL_VERIFICATION);
                              //   Get.to(const ForgotEmailtDone());
                              //   controller.signUp();
                            }
                          },
                        ),
                      )
                    : Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary),
                          ),
                        ),
                      )),
                SizedBox(height: 2.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildOTPNumber(BuildContext context) {
    return PinCodeTextField(
      focusNode: controller.otpFocusNode,
      length: 6,
      autoDisposeControllers: false,
      controller: controller.otpController,
      keyboardType: TextInputType.number,
      cursorColor: AppColors.primary,
      animationType: AnimationType.none,
      animationDuration: Duration.zero,
      pinTheme: PinTheme(
        activeColor: AppColors.grayDark,
        inactiveColor: AppColors.grayLight,
        selectedColor: AppColors.grayDark,
      ),
      onCompleted: (pin) {},
      onChanged: (pin) {
        if (pin.length == 6) {
          controller.isOtpValid(true);
          controller.otp.value = pin;
        } else {
          controller.isOtpValid(false);
          // AppToasts.showError("Invalid OTP");
        }
      },
      appContext: context,
    );
  }
}
