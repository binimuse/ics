import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/button/button_primary_fill.dart';

import 'package:ics/app/common/forms/phone_number_input.dart';

import 'package:ics/app/common/navigation/top_nav_close_text.dart';
import 'package:ics/app/config/theme/app_assets.dart';
import 'package:ics/app/config/theme/app_colors.dart';

import 'package:ics/app/config/theme/app_sizes.dart';

import 'package:ics/app/config/theme/app_text_styles.dart';

import 'package:ics/app/data/enums.dart';
import 'package:ics/app/routes/app_pages.dart';

import 'package:sizer/sizer.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.splasehimage2,
                        height: 13.h,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        "Mobile verification",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.displayOneBold
                            .copyWith(fontSize: AppSizes.font_14),
                      ),
                      SizedBox(
                        height: AppSizes.mp_v_1,
                      ),
                      Text(
                        "Please Input your phone number to continue",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.bodySmallRegular.copyWith(
                            color: AppColors.grayDark,
                            fontSize: AppSizes.font_12),
                      ),
                      SizedBox(
                        height: AppSizes.mp_v_1,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              buildCountryCode(),
                              SizedBox(
                                height: AppSizes.mp_v_1,
                              ),
                              SizedBox(
                                width: 34.w,
                                child: Divider(
                                  color: AppColors.grayLighter,
                                  thickness: 1,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: AppSizes.mp_w_4,
                          ),
                          buildPhonenumber(),
                        ],
                      ),
                      SizedBox(
                        height: AppSizes.mp_v_1,
                      ),
                      // Obx(() => controller.isPhoneValid.value &&
                      //         controller.isNextPressed.value
                      //     ? buildOTPNumber(context)
                      //     : const SizedBox()),
                      // SizedBox(
                      //   height: AppSizes.mp_v_1,
                      // ),
                      // Obx(() => controller.isPhoneValid.value &&
                      //         controller.isNextPressed.value &&
                      //         !controller.isOtpValid.value
                      //     ? Align(
                      //         alignment: Alignment.topLeft,
                      //         child: ButtonGrayScaleOutlineWithOutIcon(
                      //             buttonSizeType: ButtonSizeType.SMALL,
                      //             text: 'Send',
                      //             onTap: () {
                      //               if (controller.isNotAvalableCountry.value) {
                      //                 AppToasts.showError(
                      //                     "Error, Not a valid country");
                      //               } else {}
                      //             },
                      //             isDisabled: controller.isPhoneValid.value
                      //                 ? false
                      //                 : true),
                      //       )
                      //     : const SizedBox()),
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
                Obx(() => controller.signingUp.isFalse
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.mp_w_8,
                        ),
                        child: ButtonPrimaryFill(
                          isterms: false,
                          buttonSizeType: ButtonSizeType.LARGE,
                          isDisabled: !controller.isPhoneValid.value,
                          text: !controller.isPhoneValid.value
                              ? "Enter your phone number"
                              : "Next",
                          onTap: () {
                            if (!controller.isPhoneValid.value) {
                              // Logic for when the "Enter your phone number" button is pressed
                            } else if (!controller.isNextPressed.value) {
                              controller.isNextPressed(true);

                              // Logic for when the "Next" button is pressed
                            } else {
                              //  Get.toNamed(Routes.EMAIL_VERIFICATION);
                              //   Get.to(const ForgotEmailtDone());
                              // controller.signUp();
                              Get.toNamed(Routes.OTP_VARIFICATION);
                            }
                          },
                        ),
                      )
                    : SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.primary),
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

  buildCountryCode() {
    return Center(
      child: CountryCodePicker(
        flagDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.primaryDark,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(3, 3), // changes the shadow position
              ),
            ]),
        onChanged: (element) {
          debugPrint(element.dialCode);

          controller.countryCode = element.dialCode.toString();
        },
        initialSelection: 'IT',
        textOverflow: TextOverflow.fade,
        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')

        // optional. Shows only country name and flag
        showCountryOnly: false,
        // optional. Shows only country name and flag when popup is closed.
        showOnlyCountryWhenClosed: false,
        // optional. aligns the flag and the Text left
        alignLeft: false,
      ),
    );
  }

  buildPhonenumber() {
    return Expanded(
        child: PhoneNumberInput(
      hint: 'Phone number',
      labelText: "Phone number",
      focusNode: controller.phoneFocusNode,
      autofocus: true,
      controller: controller.phoneController,
      onChanged: (value) {
        // Validate password on type
        bool isValid =
            controller.validatPhone(); // Pass the value to validatePassword
        controller.isPhoneValid.value = isValid;

        // Check if the password is valid and display the appropriate text
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your Phone Number';
        }
        if (!controller.isPhoneValid.value) {
          return 'Invalid phone number';
        }
        return null;
      },
    ));
  }
}
