import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ics/app/common/button/button_primary_fill_login.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/forms/phone_number_input.dart';

import 'package:ics/app/common/forms/text_input_signup.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';

import 'package:ics/app/config/theme/app_assets.dart';

import 'package:ics/app/config/theme/app_colors.dart';

import 'package:ics/app/config/theme/app_sizes.dart';

import 'package:ics/app/config/theme/app_text_styles.dart';

import 'package:ics/app/data/enums.dart';

import 'package:sizer/sizer.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();

        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'ICS',
          title2: "Login",
          showLeading: true,
        ),
        //resizeToAvoidBottomInset: false,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment
                      .center, // Align the image to the center of the expanded space
                  child: Image.asset(
                    AppAssets.splasehimage2,
                    height: 13.h,
                    width: 80.w,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          key: controller.regFormKey,
                          child: Column(
                            children: [
                              Text(
                                "Login Here",
                                textAlign: TextAlign.start,
                                style: AppTextStyles.displayOneBold
                                    .copyWith(fontSize: AppSizes.font_14),
                              ),
                              SizedBox(
                                height: AppSizes.mp_v_1,
                              ),
                              Text(
                                "Please Input information continue",
                                textAlign: TextAlign.start,
                                style: AppTextStyles.bodySmallRegular.copyWith(
                                    color: AppColors.grayDark,
                                    fontSize: AppSizes.font_12),
                              ),
                              SizedBox(
                                height: AppSizes.mp_v_4,
                              ),
                              buildPhoneinput(),

                              SizedBox(height: 1.h),

                              // Show Password field only when Next is pressed

                              if (controller.isNextPressed.value ||
                                  controller.passwordController.text.isNotEmpty)
                                buildpininput()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Column(
                  children: [
                    Obx(
                      () => SizedBox(
                        height: controller.isNextPressed.value ||
                                controller.passwordController.text.isNotEmpty
                            ? 0.0
                            : 5.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.mp_w_4,
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildFindEmailButton(),
                              SizedBox(
                                height: 2.h,
                                child: VerticalDivider(
                                  color: AppColors.secondary,
                                  thickness: 2,
                                ),
                              ),
                              buildFindPassswordButton(),
                            ],
                          ),

                          // SizedBox(height: 1.h),

                          Obx(
                            () => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: buildButton(context)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Obx(
              () => controller.networkStatus.value == NetworkStatus.LOADING
                  ? CustomLoadingWidget()
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  buildCountryCode() {
    return CountryCodePicker(
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

  buildPhoneinput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCountryCode(),
        SizedBox(
          width: AppSizes.mp_w_4,
        ),
        buildPhonenumber(),
      ],
    );
  }

  buildpininput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      child: TextInputSignup(
        hint: 'Pin',
        maxLength: 6,
        moreInstructions: const [
          "Maximum  6 digits",
          "Only Numbers",
        ],
        keyboardType: TextInputType.number,
        isPassword: true,
        onChanged: (value) {
          // Validate password on type

          bool isValid = controller.validatePassword();

          controller.isPasswordValid.value = isValid;

          // Check if the password is valid and display the appropriate text
        },

        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your pin';
          }

          if (!controller.isPasswordValid.value) {
            return 'Pin must be 6';
          }

          return null;
        },

        controller: controller.passwordController,

        autofocus: controller
            .isNextPressed.value, // Set autofocus to true when Next is pressed

        focusNode: controller.passwordFocusNode, // Pass the password focus node
      ),
    );
  }

  buildFindEmailButton() {
    return MaterialButton(
      onPressed: () {
        // Get.dialog(

        //   const DialogFindEmail(),

        //   barrierDismissible: true,

        // );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Center(
          child: Text(
            "Find Phone",
            style: AppTextStyles.bodySmallUnderlineRegular
                .copyWith(color: AppColors.grayLight),
          ),
        ),
      ),
    );
  }

  buildFindPassswordButton() {
    return MaterialButton(
      onPressed: () {
        // Get.toNamed(Routes.FIND_PASSWORD);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Center(
          child: Text(
            "Find Pin",
            style: AppTextStyles.bodySmallUnderlineRegular
                .copyWith(color: AppColors.grayLight),
          ),
        ),
      ),
    );
  }

  buildButton(BuildContext context) {
    final isPhoneNumbervalid = controller.isPhoneValid.value;

    final isNextPressed = controller.isNextPressed.value;

    final isPasswordValid = controller.isPasswordValid.value;

    late Color buttonColors;

    bool isDisabled = (!isPhoneNumbervalid && !isPasswordValid) ||
        (isPhoneNumbervalid && !isNextPressed && !isPasswordValid);

    String buttonText;

    if (isPhoneNumbervalid) {
      if (isNextPressed) {
        if (isPasswordValid) {
          buttonText = "Log in";

          buttonColors = AppColors.primary;
        } else {
          buttonText = "Enter Pin";

          buttonColors = AppColors.grayLight;
        }
      } else {
        if (isPasswordValid) {
          buttonText = "Log in";

          buttonColors = AppColors.primary;
        } else {
          buttonText = "Next";

          buttonColors = AppColors.black;
        }
      }
    } else {
      if (isPasswordValid) {
        buttonText = "Log in";

        buttonColors = AppColors.grayLight;
      } else {
        buttonText = "Enter your phone number";

        buttonColors = AppColors.grayLight;
      }
    }

    return ButtonPrimaryFillLogin(
      buttonSizeType: ButtonSizeTypeLogin.MEDIUM,
      isDisabled: isDisabled,
      buttonColor: buttonColors,
      text: buttonText,
      onTap: () {
        if (isPhoneNumbervalid && !isNextPressed) {
          controller.isNextPressed(true);

          Future.delayed(const Duration(milliseconds: 100), () {
            FocusScope.of(context).requestFocus(controller.passwordFocusNode);
          });
        } else if (isPhoneNumbervalid && isPasswordValid) {
          controller.signIn(context);

          // Handle login logic
        } else {
          print(isPhoneNumbervalid);

          print(isNextPressed);

          //  Get.offAllNamed(Routes.MAIN_PAGE);

          // Handle login logic
        }
      },
    );
  }
}
